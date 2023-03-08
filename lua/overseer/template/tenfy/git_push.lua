return {
    name = 'git push',
    builder = function(params)
        return {
            cmd = 'git',
            args = { 'push' },
            name = 'git push',
            cwd = vim.fn.getcwd(),
        }
    end,
    desc = 'git push',
}
