--[[
- @file fzf.lua
- @brief
- @author tenfyzhong
- @email tenfy@tenfy.cn
- @created 2023-01-27 20:06:26
--]]

local fzf = {
	"junegunn/fzf",
	build = ":call fzf#install()",
	lazy = true,
}

local function find_tag()
	if vim.bo.filetype == "NvimTree" or vim.bo.filetype == "neo-tree" or vim.bo.filetype == "aerial" then
		require("fzf-lua").blines()
	else
		require("aerial").fzf_lua_picker({ fzf_opts = {
			["--layout"] = "reverse",
		} })
	end
end

local fzf_lua = {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons", fzf },
	config = function()
		require("fzf-lua").setup({
			"hide",
		})
	end,
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: files",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: buffers",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").git_files()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: git_files",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").grep_project()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: grep_project",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").command_history()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: command_history",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").commands()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: commands",
		},
		{
			"<leader>f/",
			function()
				require("fzf-lua").search_history()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: search_history",
		},
		{
			"<leader>fT",
			function()
				require("fzf-lua").tags()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: tags",
		},
		{
			"<leader>ft",
			find_tag,
			silent = true,
			remap = false,
			desc = "fzf-lua: buffer tags",
		},
		{
			"<leader>fm",
			function()
				require("fzf-lua").marks()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: marks",
		},
		{
			"<leader>fz",
			function()
				require("fzf-lua").zoxide()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: zoxide",
		},
		{
			"<leader>fs",
			function()
				local store = os.getenv("FZF_MARKS_FILE")
				if not store then
					store = os.getenv("HOME") .. "/.fzf-marks"
				end
				require("fzf-lua").fzf_exec("cat " .. store, {
					actions = {
						["default"] = function(selected)
							if not selected then
								return
							end

							local parts = vim.split(selected[1], ":")
							if #parts >= 2 then
								local path = vim.fn.expand(parts[2])
								vim.fn.chdir(path)
								require("neo-tree.command").execute({
									action = "focus",
								})
							end
						end,
					},
				})
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: fzf-marks",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").keymaps()
			end,
			silent = true,
			remap = false,
			desc = "fzf-lua: keymaps",
		},
	},
	cmd = { "FzfLua" },
}

-- local fzf_vim = {
-- 	"junegunn/fzf.vim",
-- 	-- event = 'VeryLazy',
-- 	dependencies = { "stevearc/aerial.nvim", fzf[1] },
-- 	init = function()
-- 		vim.g.fzf_command_prefix = "FZF"
-- 		vim.g.fzf_history_dir = "~/.fzf-history"
-- 	end,
-- 	config = function() end,
-- 	cmd = { "FZF", "FZFFiles", "FZFGFiles", "FZFBuffers", "FZFRg", "FZFAg" },
-- 	keys = {
-- 		{ "<leader>ff", ":FZFFiles<cr>", silent = true, remap = false, desc = "fzf: files" },
-- 		{ "<leader>fg", ":FZFGFiles<cr>", silent = true, remap = false, desc = "fzf: git files" },
-- 		{ "<leader>fb", ":FZFBuffers<cr>", silent = true, remap = false, desc = "fzf: buffers" },
-- 		{ "<leader>fr", ":FZFRg<cr>", silent = true, remap = false, desc = "fzf: rg" },
-- 		{ "<leader>fa", ":FZFAg<cr>", silent = true, remap = false, desc = "fzf: ag" },
-- 		{
-- 			"<leader>fA",
-- 			function()
-- 				local cword = vim.fn.expand("<cword>")
-- 				vim.cmd(vim.g.fzf_command_prefix .. "Ag " .. cword .. "<cr>")
-- 			end,
-- 			silent = true,
-- 			remap = false,
-- 			desc = "fzf: ag cword",
-- 		},
-- 		{ "<leader>fh", ":FZFHistory<cr>", silent = true, remap = false, desc = "fzf: command history" },
-- 		{ "<leader>fw", ":FZFWindows<cr>", silent = true, remap = false, desc = "fzf: windows" },
-- 		{ "<leader>fc", ":FZFCommands<cr>", silent = true, remap = false, desc = "fzf: commands" },
-- 		{ "<leader>/", ":FZFHistory/<cr>", silent = true, remap = false, desc = "fzf: search history" },
-- 		{ "<leader>fT", ":FZFTags<cr>", silent = true, remap = false, desc = "fzf: ctags" },
-- 		{ "<leader>fm", ":FZFMarks<cr>", silent = true, remap = false, desc = "fzf: marks" },
-- 		{ "<leader>ft", find_tag, silent = true, remap = false, desc = "fzf: find buffer tag" },
--
-- 		{
-- 			"<leader><leader>",
-- 			"<plug>(fzf-maps-n)",
-- 			mode = "n",
-- 			silent = false,
-- 			remap = true,
-- 			desc = "fzf: nmap",
-- 		},
-- 		{
-- 			"<leader><leader>",
-- 			"<plug>(fzf-maps-o)",
-- 			mode = "o",
-- 			silent = false,
-- 			remap = true,
-- 			desc = "fzf: omap",
-- 		},
-- 		{
-- 			"<leader><leader>",
-- 			"<plug>(fzf-maps-x)",
-- 			mode = "x",
-- 			silent = false,
-- 			remap = true,
-- 			desc = "fzf: xmap",
-- 		},
-- 	},
-- }

-- local marks = {
-- 	"tenfyzhong/fzf-marks.vim",
-- 	dependencies = { fzf[1] },
-- 	config = function()
-- 		local group = vim.api.nvim_create_augroup("fzf_marks_local", {})
-- 		vim.api.nvim_create_autocmd("User", {
-- 			group = group,
-- 			pattern = "FZFMarksCd",
-- 			callback = function()
-- 				local cwd = vim.fn.getcwd()
-- 				require("nvim-tree.api").tree.open({ path = cwd })
-- 			end,
-- 		})
-- 	end,
-- 	keys = {
-- 		{ "<leader>fs", ":FZFFzm<cr>", silent = true, remap = false, desc = "fzf-marks: marks" },
-- 	},
-- 	cmd = { "FZFFzm" },
-- }

local bookmarks = {
	"tenfyzhong/fzf-bookmarks.vim",
	dependencies = { fzf[1] },
	config = function() end,
	keys = {
		{ "<leader>fM", ":FZFBookmarks<cr>", silent = true, remap = false, desc = "fzf-bookmarks: bookmarks" },
	},
	cmd = { "FZFBookmarks" },
}

-- local z = {
-- 	"tenfyzhong/z.nvim",
-- 	dependencies = { fzf[1] },
-- 	config = function()
-- 		require("z").setup({})
--
-- 		local group = vim.api.nvim_create_augroup("z_local", {})
-- 		vim.api.nvim_create_autocmd("User", {
-- 			group = group,
-- 			pattern = "Zcd",
-- 			callback = function()
-- 				local cwd = vim.fn.getcwd()
-- 				require("nvim-tree.api").tree.open({ path = cwd })
-- 			end,
-- 		})
-- 	end,
-- 	keys = {
-- 		{ "<leader>fz", ":FZFZ<cr>", silent = true, remap = false, desc = "z: z" },
-- 	},
-- 	cmd = { "FZFZ" },
-- }
--
return { fzf, fzf_lua, marks, bookmarks }
