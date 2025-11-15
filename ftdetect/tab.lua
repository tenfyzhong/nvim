local tab2 = {
    "css",
    "ejs",
    "html",
    "htmldjango",
    "htmljanja",
    "jade",
    "pug",
    "javascript",
    "typescript",
    "vue",
    "yaml",
}

local noexpand = {
    "make",
    "go",
}

local function contains(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local function env_tab(ft)
    local ft_upper = ft:upper()
    local res = false

    local expandtab = os.getenv("VIM_EXPANDTAB_" .. ft_upper)
    if expandtab and expandtab == "0" then
        vim.bo.expandtab = false
        res = true
    end

    local tabwidth = os.getenv("VIM_TABWIDTH_" .. ft_upper)
    if tabwidth and tabwidth ~= "" then
        local width = tonumber(tabwidth)
        vim.bo.tabstop = width
        vim.bo.softtabstop = width
        vim.bo.shiftwidth = width
        res = true
    end

    return res
end

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*",
    callback = function()
        local ft = vim.bo.filetype

        if env_tab(ft) then
            env_tab(ft)
        elseif contains(tab2, ft) then
            vim.bo.tabstop = 2
            vim.bo.softtabstop = 2
            vim.bo.shiftwidth = 2
            vim.bo.expandtab = true
        elseif contains(noexpand, ft) then
            vim.bo.expandtab = false
        end
    end,
})
