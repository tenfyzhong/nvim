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

function XXD()
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
