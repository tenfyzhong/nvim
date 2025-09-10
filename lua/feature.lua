function poll_number()
    if vim.o.number and vim.o.relativenumber then
        vim.o.number = true
        vim.o.relativenumber = false
    elseif vim.o.number or vim.o.relativenumber then
        vim.o.number = false
        vim.o.relativenumber = false
    else
        vim.o.number = true
        vim.o.relativenumber = true
    end
end

function xxd()
    if vim.b.is_xxd == nil then
        vim.b.is_xxd = false
    end
    local mod = vim.o.mod
    if vim.b.is_xxd then
        vim.o.binary = false
        vim.cmd("silent %!xxd -r")
        vim.b.is_xxd = false
    else
        vim.binary = true
        vim.cmd("silent %!xxd")
        vim.b.is_xxd = true
    end
    vim.o.mod = mod
end

function format(fmt)
    local bufnr = vim.api.nvim_get_current_buf()

    if vim.o.mod == true then
        vim.cmd("noautocmd silent write")
    end

    vim.o.lazyredraw = true

    local winnrs = vim.fn.win_findbuf(bufnr)
    for _, winnr in ipairs(winnrs) do
        vim.fn.win_execute(winnr, "let w:go_view = winsaveview()")
    end
    vim.cmd("wshada")

    fmt()

    if vim.o.mod == true then
        vim.cmd("noautocmd silent write")
    end

    -- restore the winview belongs to the buf
    for _, winnr in ipairs(winnrs) do
        vim.fn.win_execute(winnr, 'call winrestview(get(w:, "go_view", winsaveview()))')
    end

    vim.cmd("rshada")
    vim.o.lazyredraw = false
    vim.cmd("redraw!")
end

-- Helper function: Normalizes a path and returns its component list.
-- Parameters:
--   path: The path string to be normalized.
--   is_absolute_input: Boolean, indicates if the original path was absolute (starts with '/').
-- Returns:
--   An array of tables, containing the path's components. For absolute paths,
--   an empty string `""` is added at the beginning as a placeholder for the root directory.
local function getNormalizedPathComponents(path, is_absolute_input)
    local components = {}
    local raw_segments = {}

    -- Split the path into raw segments, ignoring empty segments (e.g., from "//")
    for part in path:gmatch("[^/]+") do
        table.insert(raw_segments, part)
    end

    for _, part in ipairs(raw_segments) do
        if part == "." then
            -- Ignore the current directory '.'
            -- Do nothing
        elseif part == ".." then
            -- Handle parent directory '..'
            if #components > 0 and components[#components] ~= ".." then
                -- If the previous component is not '..', remove it (go up one level)
                table.remove(components)
            elseif not is_absolute_input then
                -- If it's a relative path and already beyond the starting point, keep '..'
                table.insert(components, "..")
                -- else: If it's an absolute path and at the root, '..' is ignored
            end
        elseif part ~= "" then
            -- Add valid components
            table.insert(components, part)
        end
    end

    -- If it's an absolute path, add an empty string at the beginning of the component list as a root directory placeholder.
    if is_absolute_input then
        table.insert(components, 1, "")
    end

    return components
end

-- Helper function: Reconstructs a normalized path string from a list of components.
-- @param components table An array of path components.
-- @param is_absolute_input boolean True if the original path was absolute.
-- @return string The reconstructed normalized path string.
local function reconstructNormalizedPath(components, is_absolute_input)
    if #components == 0 then
        -- If the component list is empty, for an absolute path it means the root "/", for a relative path it means an empty string ""
        return is_absolute_input and "/" or ""
    end

    if is_absolute_input and components[1] == "" then
        -- If the first component is the root directory placeholder ""
        if #components == 1 then
            return "/" -- The path is just the root "/"
        else
            -- Remove the root directory placeholder, then concatenate the remaining components, and prefix with "/"
            local temp_components = {}
            for i = 2, #components do
                table.insert(temp_components, components[i])
            end
            return "/" .. table.concat(temp_components, "/")
        end
    end

    -- Otherwise, just concatenate the components
    return table.concat(components, "/")
end

--- Calculates the relative path of path A (pathA) based on path B (pathB).
-- @param pathA string The target path.
-- @param pathB string The base path.
-- @return string The relative path of pathA based on pathB.
local function getRelativePath(pathA, pathB)
    -- First, determine if both paths are absolute
    local is_abs_A = pathA:sub(1, 1) == "/"
    local is_abs_B = pathB:sub(1, 1) == "/"

    -- If one path is absolute and the other is relative, a meaningful relative path cannot be calculated.
    -- In such cases, it typically falls back to returning the original pathA.
    if is_abs_A ~= is_abs_B then
        return pathA
    end

    -- Get the normalized component lists for both paths
    local partsA = getNormalizedPathComponents(pathA, is_abs_A)
    local partsB = getNormalizedPathComponents(pathB, is_abs_B)

    -- Reconstruct normalized string paths to check if paths are completely identical.
    local norm_str_A = reconstructNormalizedPath(partsA, is_abs_A)
    local norm_str_B = reconstructNormalizedPath(partsB, is_abs_B)

    -- If the two normalized paths are identical, the relative path is "."
    if norm_str_A == norm_str_B then
        return "."
    end

    -- Find the length of the common prefix
    local common_length = 0
    local min_len = math.min(#partsA, #partsB)
    for i = 1, min_len do
        if partsA[i] == partsB[i] then
            common_length = i
        else
            break
        end
    end

    -- Calculate the number of 'up' steps needed from pathB to the common ancestor
    local up_steps = #partsB - common_length
    local relative_parts = {}
    for i = 1, up_steps do
        table.insert(relative_parts, "..")
    end

    -- Calculate the path components needed to go down from the common ancestor to pathA
    for i = common_length + 1, #partsA do
        table.insert(relative_parts, partsA[i])
    end

    -- Concatenate the relative path components
    return table.concat(relative_parts, "/")
end

return {
    poll_number = poll_number,
    xxd = xxd,
    format = format,
    getRelativePath = getRelativePath,
}
