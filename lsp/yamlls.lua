return {
    settings = {
        yaml = {
            schemas = {
                kubernetes = "k8s-*.{yml,yaml}",
                ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["https://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
                ["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
            },
        },
    },
}
