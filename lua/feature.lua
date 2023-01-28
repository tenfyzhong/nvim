module('feature', package.seeall)

function PollNumber()
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

function DefxCwd()
    if packer_plugins['defx.nvim'] and packer_plugins['defx.nvim'].loaded then
        local pwd = vim.fn.getcwd()
        local tabnr = vim.fn.tabpagenr()
        vim.cmd(string.format('Defx -buffer-name=defx%d %s', tabnr, pwd))
    end
end
