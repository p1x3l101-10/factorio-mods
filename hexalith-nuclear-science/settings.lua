require("settings.peaceful-nauvis")
require("settings.hexalith-difficulty")
require("settings.strict-biotech")
require("settings.strict-biotech-wood")

if mods["diverse-external-rocket-parts"] then
  require("compatibility.diverse-external-rocket-parts.settings")
end

if mods["carbon"] then
  require("compatibility.carbon.settings")
end