require("prototypes.entity-final-fixes")
require("prototypes.worldgen-final-fixes")

if mods["extraplanetary-production"] then
  require("compatibility.extraplanetary-production.data-final-fixes")
end
if mods["carbon"] then
  require("compatibility.carbon.data-final-fixes")
end