return {
    name = 'git pull',
    builder = function(params)
        return {
            cmd = 'git',
            args = { 'pull' },
            name = 'git pull',
            cwd = vim.fn.getcwd(),
        }
    end,
    desc = 'git pull',
    priority = 100,
}
