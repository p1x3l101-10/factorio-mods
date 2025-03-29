local Technology = require("__cf-lib__/data/Technology")

if mods["alloy-smelting"] and mods["lignumis"] and not mods["aai-industry"] then
  Technology:new("burner-mechanics"):addPrerequisite("automation-science-pack")
end

if mods["lignumis"] and mods["aai-industry"] then
  Technology:new("automation-science-pack"):addPrerequisite("copper-processing")
end