--- Toggles the line numbering mode in the current window.
-- It cycles through three states:
-- 1. From relative numbers to absolute numbers.
-- 2. From absolute numbers to no numbers.
-- 3. From no numbers to relative numbers.
local function poll_number()
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

--- Toggles the buffer's display between normal text and a hexadecimal representation using `xxd`.
-- It preserves the buffer's modification status.
local function xxd()
    if vim.b.is_xxd == nil then
        vim.b.is_xxd = false
    end
    local mod = vim.o.mod
    if vim.b.is_xxd then
        vim.o.binary = false
        vim.cmd("silent %!xxd -r")
        vim.b.is_xxd = false
    else
        vim.o.binary = true
        vim.cmd("silent %!xxd")
        vim.b.is_xxd = true
    end
    vim.o.mod = mod
end

--- Formats the current buffer using a provided formatter function.
-- It saves the current view (cursor position, etc.), runs the formatter,
-- and then restores the view. It also handles saving the buffer before
-- and after formatting if it was modified.
-- @param fmt function The formatter function to execute.
-- @param opts table|nil Optional options. Set opts.save=false to skip pre/post writes.
local function format(fmt, opts)
    opts = opts or {}
    local save = opts.save ~= false
    local bufnr = vim.api.nvim_get_current_buf()

    if save and vim.o.mod == true then
        vim.cmd("noautocmd silent write")
    end

    vim.o.lazyredraw = true

    local winnrs = vim.fn.win_findbuf(bufnr)
    for _, winnr in ipairs(winnrs) do
        vim.fn.win_execute(winnr, "let w:go_view = winsaveview()")
    end
    vim.cmd("wshada")

    fmt()

    if save and vim.o.mod == true then
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
local function get_normalized_path_components(path, is_absolute_input)
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
local function reconstruct_normalized_path(components, is_absolute_input)
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
local function get_relative_path(pathA, pathB)
    -- First, determine if both paths are absolute
    local is_abs_A = pathA:sub(1, 1) == "/"
    local is_abs_B = pathB:sub(1, 1) == "/"

    -- If one path is absolute and the other is relative, a meaningful relative path cannot be calculated.
    -- In such cases, it typically falls back to returning the original pathA.
    if is_abs_A ~= is_abs_B then
        return pathA
    end

    -- Get the normalized component lists for both paths
    local partsA = get_normalized_path_components(pathA, is_abs_A)
    local partsB = get_normalized_path_components(pathB, is_abs_B)

    -- Reconstruct normalized string paths to check if paths are completely identical.
    local norm_str_A = reconstruct_normalized_path(partsA, is_abs_A)
    local norm_str_B = reconstruct_normalized_path(partsB, is_abs_B)

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

--- Parses a string into a list of arguments, respecting quotes and escape characters.
-- Whitespace is used as a delimiter. Text within single or double quotes is treated as a single argument.
-- @param s string The input string to parse.
-- @return table A list of parsed arguments. Returns an empty table if the input is nil.
local function parse_args(s)
    if not s then
        return {}
    end

    local args = {}
    local i = 1 -- Start at the beginning of the string
    local in_quotes = false
    local quote_type = nil
    local arg = ""

    while i <= #s do
        local char = s:sub(i, i)

        if in_quotes then
            if char == "\\" and i + 1 <= #s then -- Handle escape
                i = i + 1 -- Skip the escape character
                arg = arg .. s:sub(i, i) -- Add the escaped character
            elseif char == quote_type then
                in_quotes = false -- End of quoted string
                table.insert(args, arg)
                arg = ""
            else
                arg = arg .. char
            end
            i = i + 1
        else
            if char:match("%s") then -- Skip whitespace
                if arg ~= "" then
                    table.insert(args, arg)
                    arg = ""
                end
            elseif char == '"' or char == "'" then
                in_quotes = true
                quote_type = char
            else
                arg = arg .. char
            end
            i = i + 1
        end
    end

    if arg ~= "" then
        table.insert(args, arg) -- Add any remaining argument
    end

    return args
end

--- Ensures a given value is a list (table).
-- If the value is a string, it's wrapped in a table.
-- If it's a table, it's returned as is.
-- If it's a function, it's executed, and the result is recursively parsed.
-- @param value any The value to convert.
-- @return table A list representation of the value, or an empty table if conversion is not possible.
local function to_list(value)
    local value_type = type(value)
    if value_type == "string" then
        return { value }
    elseif value_type == "table" then
        return value
    elseif value_type == "function" then
        local success, result = pcall(value)
        if success then
            return to_list(result)
        end
    end
    return {}
end

--- Ensures shell buffers use literal tabs instead of spaces.
-- It updates the current buffer immediately if needed and registers a FileType
-- autocmd for future shell buffers. Safe to call multiple times.
local function setup_sh_noexpandtab()
    local group = vim.api.nvim_create_augroup("feature_sh_noexpandtab", {
        clear = true,
    })

    local function set_sh_noexpandtab(bufnr)
        if vim.bo[bufnr].filetype == "sh" then
            vim.bo[bufnr].expandtab = false
        end
    end

    set_sh_noexpandtab(0)

    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "sh",
        callback = function(args)
            set_sh_noexpandtab(args.buf)
        end,
    })
end

return {
    poll_number = poll_number,
    xxd = xxd,
    format = format,
    get_relative_path = get_relative_path,
    parse_args = parse_args,
    to_list = to_list,
    setup_sh_noexpandtab = setup_sh_noexpandtab,
}
