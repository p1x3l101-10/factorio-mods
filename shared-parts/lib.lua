local M = {
  graphics = {},
  optional = {}
}

M.graphics.achievement = require("lib.graphics.achievement")
M.functions = require("lib.functions")

if mods["diverse-external-rocket-parts"] then
  M.optional.diverse_external_rocket_parts = require("lib.optional.diverse_external_rocket_parts")
end

return M