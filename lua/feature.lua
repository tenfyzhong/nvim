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

function GoGet(p)
    if packer_plugins['asyncrun.vim'] and packer_plugins['asyncrun.vim'].loaded then
        vim.cmd(string.format('AsyncRun -cwd=$(VIM_FILEDIR) -silent -post=echom\\ "go\\ get\\ %s\\ finish" go get %s'
            , p
            , p))
    else
        vim.cmd(string.format('!go get %s'), p)
    end
end

local function getCommand(opt)
    if opt.args and opt.args ~= '' then
        GoGet(opt.args)
        return
    end

    -- if no packer provided, try to use the current line content
    local lnum = vim.fn.line('.')
    local line = vim.fn.getline(lnum)
    for p in string.gmatch(line, '"(.*)"') do
        GoGet(p)
        return
    end

    print('GoGet: no package provided')
end

function GoGetCommand()
    local group = vim.api.nvim_create_augroup('go_get', {})
    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'go',
        callback = function()
            vim.api.nvim_buf_create_user_command(0, 'GoGet', getCommand, {
                nargs = '?',
            })
        end,
    })
end
