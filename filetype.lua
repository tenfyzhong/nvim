vim.filetype.add({
    extension = {
        bats = "bats.sh",
        iptables = "iptables",
        kdl = "kdl",
        mmd = "mermaid",
        mermaid = "mermaid",
        coffee = "coffee",
    },
    filename = {
        ["Cargo.toml"] = "cargo.toml",
        [".envrc"] = "direnv.envrc.sh",
    },
})
