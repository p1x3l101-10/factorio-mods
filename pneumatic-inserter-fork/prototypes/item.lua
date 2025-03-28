local fluidInserterLib = require("fluidInserterLib")

fluidInserterLib.icons_predefined["pneumatic-inserter"] = "__pneumatic-inserter-fork__/graphics/icons/pneumatic-inserter.png"
fluidInserterLib.icons_predefined["pneumatic-long-handed-inserter"] = "__pneumatic-inserter-fork__/graphics/icons/pneumatic-long-handed-inserter.png"

data:extend({
  fluidInserterLib.createFluidInserterItem("burner-inserter", "burner-inserter", "gold-pipe", "steam"),
  fluidInserterLib.createFluidInserterItem("burner-long-handed-inserter", "burner-long-handed-inserter", "gold-pipe", "steam")
})