local util = require("__core__.lualib")
local fluidInserterLib = require("fluidInserterLib")

data:extend({
  fluidInserterLib.createFluidInserterEntity("pneumatic-inserter", "inserter", "gold-pipe", "steam", 165),
  util.merge({
    fluidInserterLib.createFluidInserterEntity("pneumatic-inserter", "inserter", "gold-pipe", "steam", 165),
    -- like long handed inserter
	  rotation_speed = 0.02,
	  extension_speed = 0.0457,
	  -- halfway between burner inserter and electric inserter
	  energy_per_movement = "30KJ",
	  energy_per_rotation = "30KJ",
  })
})