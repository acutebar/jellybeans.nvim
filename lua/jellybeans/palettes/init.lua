local M = {}

---@class ColorScheme: Palette
function M.get_palette(palette, opts)
  -- Set palette to "jellybeans" (default) or the specified palette
  local type_palette = palette or "jellybeans"

  -- Add "_light" suffix for light style
  if opts.style == "light" then
    type_palette = type_palette .. "_light"
  end

  -- Try to load the specified palette
  local ok, colors = pcall(require, "jellybeans.palettes." .. type_palette)
  if not ok then
    vim.notify("Failed to load palette: " .. type_palette, vim.log.levels.ERROR)
    -- Fall back to default jellybeans palette
    return require("jellybeans.palettes.jellybeans")
  end

  if opts.on_colors then
    opts.on_colors(colors)
  end
  return colors
end

return M
