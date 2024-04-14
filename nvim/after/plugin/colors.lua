function Colors(color)
  -- "rose-pine-moon"
	color = color or "material-deep-ocean"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "black" })
end

Colors()
