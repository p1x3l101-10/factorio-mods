local M = {
  parts = {},
  raw = {}
}

local functions = require("lib.functions")

function M.raw.image(pathlet, size)
  return {
    icon = "__p1x3l101-shared-parts__/graphics/achievement/" .. pathlet .. ".png",
    icon_size = size
  }
end

function M.parts.base(name)
  return M.raw.image("base/" .. name, 128)
end

function M.parts.icons(name, extraValues)
  local tbl = M.raw.image("parts/icons/" .. name, 128)
  return functions.merge(tbl, extraValues)
end

return M