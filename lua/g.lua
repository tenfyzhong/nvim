local python_host = vim.fn.exepath("python")
if python_host ~= "" then
    vim.g.python_host_prog = python_host
end

local python3_host = vim.fn.exepath("python3")
if python3_host ~= "" then
    vim.g.python3_host_prog = python3_host
end

vim.g.mapleader = "'"
vim.g.maplocalleader = ","
