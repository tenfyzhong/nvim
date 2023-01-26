module('feature')

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
