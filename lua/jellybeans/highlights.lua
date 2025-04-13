local M = {}

---@param opts? jellybeans.Config
function M.setup(opts)
  if not opts then
    opts = require("jellybeans.config").opts
  end

  local current_scheme = vim.g.colors_name

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.opt.termguicolors = true

  vim.o.background = opts.style == "light" and "light" or "dark"
  vim.g.colors_name = current_scheme or "jellybeans"

  local colors = require("jellybeans.palettes").get_palette(opts.palette or "jellybeans", opts)
  if not colors then
    vim.notify("Failed to load jellybeans colorscheme", vim.log.levels.ERROR)
    return
  end

  local groups = require("jellybeans.groups").setup(colors, opts)

  for group, hl in pairs(groups) do
    hl = type(hl) == "string" and { link = hl } or hl
    vim.api.nvim_set_hl(0, group, hl)
  end

  return colors, groups, opts
end

return M
