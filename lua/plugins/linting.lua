return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			-- Define kube-linter since it's not built into nvim-lint
			lint.linters.kube_linter = {
				name = "kube-linter",
				cmd = "kube-linter",
				stdin = false,
				args = { "lint", "--format=json" },
				stream = "stdout",
				ignore_exitcode = true,
				parser = function(output)
					local diagnostics = {}
					local ok, decoded = pcall(vim.json.decode, output)
					if not ok or not decoded or not decoded.Reports then
						return diagnostics
					end

					for _, report in ipairs(decoded.Reports) do
						table.insert(diagnostics, {
							lnum = 0,
							col = 0,
							message = report.Check .. ": " .. report.Message,
							severity = vim.diagnostic.severity.WARN,
							source = "kube-linter",
						})
					end

					return diagnostics
				end,
			}

			-- Configure linters by filetype
			lint.linters_by_ft = {
				yaml = { "yamllint" },
				["yaml.ansible"] = { "ansible_lint" },
				helm = { "kube_linter" },
				sh = { "shellcheck" },
			}

			-- Auto-lint on save
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
			local tools = { "yamllint", "ansible-lint", "kube-linter", "shellcheck" }
			local registry = require("mason-registry")
			registry.refresh(function()
				for _, tool in ipairs(tools) do
					local ok, pkg = pcall(registry.get_package, tool)
					if ok and not pkg:is_installed() then
						pkg:install()
					end
				end
			end)
		end,
	},
}
