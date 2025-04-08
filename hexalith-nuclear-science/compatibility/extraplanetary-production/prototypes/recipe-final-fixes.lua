local util = require("functions").recipe
if settings.startup["basic-science-changes"].value then
  util.set_category("advanced-military-science-pack", "centrifuging")
  -- Remove other recipes
  if settings.startup["basic-science-changes"].value then
    util.set_category("automation-science-pack", "crafting")
    util.set_category("logistic-science-pack", "crafting")
    util.set_category("military-science-pack", "crafting")
  end
end