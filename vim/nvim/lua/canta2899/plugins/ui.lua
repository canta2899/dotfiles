return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local nvtree = require("nvim-tree")
			nvtree.setup({
				diagnostics = {
					enable = true,
					show_on_dirs = true,
				},
			})
			vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
			--
			-- other commands are
			-- NvimTreeFocus (Open the tree if it is closed, and then focus on the tree).
			-- NvimTreeFindFile (Move the cursor in the tree for the current buffer, opening folders if needed).
			-- NvimTreeCollapse (Collapses the nvim-tree recursively).
		end,
	},

	{
		"j-morano/buffer_manager.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local buf = require("buffer_manager.ui")

			vim.keymap.set("n", "<C-b>", buf.toggle_quick_menu)
			vim.keymap.set("n", "<Tab>", buf.nav_next)
			vim.keymap.set("n", "<S-Tab>", buf.nav_prev)
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
