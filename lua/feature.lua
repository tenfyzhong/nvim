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
        vim.cmd('silent %!xxd -r')
        vim.b.is_xxd = false
    else
        vim.binary = true
        vim.cmd('silent %!xxd')
        vim.b.is_xxd = true
    end
    vim.o.mod = mod
end

function format(fmt)
    local bufnr = vim.api.nvim_get_current_buf()

    if vim.o.mod == true then
        vim.cmd('noautocmd silent write')
    end

    vim.o.lazyredraw = true

    local winnrs = vim.fn.win_findbuf(bufnr)
    for _, winnr in ipairs(winnrs) do
        vim.fn.win_execute(winnr, 'let w:go_view = winsaveview()')
    end
    vim.cmd('wshada')

    fmt()

    if vim.o.mod == true then
        vim.cmd('noautocmd silent write')
    end

    -- restore the winview belongs to the buf
    for _, winnr in ipairs(winnrs) do
        vim.fn.win_execute(winnr, 'call winrestview(get(w:, "go_view", winsaveview()))')
    end

    vim.cmd('rshada')
    vim.o.lazyredraw = false
    vim.cmd('redraw!')
end

return {
    poll_number = poll_number,
    xxd = xxd,
    format = format,
}
