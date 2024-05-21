vim.filetype.add({
    extension = {
        bats = 'bats.sh',
        iptables = 'iptables',
        kdl = 'kdl',
        mmd = 'mermaid',
        mermaid = 'mermaid',
    },
    filename = {
        ['Cargo.toml'] = 'cargo.toml',
        ['.envrc'] = 'envrc.bash',
    },
})
