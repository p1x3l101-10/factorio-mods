require "fluidInserterLib"

-- use custom icons
fluidInserterLib.icons_predefined["pneumatic-inserter"] = "__pneumatic-inserter__/graphics/icons/pneumatic-inserter.png"
fluidInserterLib.icons_predefined["pneumatic-long-handed-inserter"] = "__pneumatic-inserter__/graphics/icons/pneumatic-long-handed-inserter.png"

local pipe = "gold-pipe"

-- create using the lib
local entity = fluidInserterLib.createFluidInserterEntity("pneumatic-inserter", "inserter", pipe, "steam", 165)
local item = fluidInserterLib.createFluidInserterItem("pneumatic-inserter", "inserter", pipe, "steam")
local unlockd_by_tech = {"pneumatic-inserter"}

-- fine tuning
entity = util.merge({entity,	-- util is defined in factorio.core.lualib
	-- like inserter
	extension_speed = 0.03,
	rotation_speed = 0.014,
	-- halfway between burner inserter and electric inserter
	energy_per_movement = "30KJ",
    energy_per_rotation = "30KJ",
})

-- add recipe
local recipe = {
    type = "recipe",
    name = "pneumatic-inserter",
    enabled = false,
    ingredients = {
      {pipe, 1},
      {"gold-plate", 1},
      {"burner-inserter", 1}
    },
    results = {
      { type = "item", name = "pneumatic-inserter", amount = 1 }
    }
}

-- add to game
data:extend({entity, item, recipe})


local entity = fluidInserterLib.createFluidInserterEntity("burner-long-handed-inserter", "burner-long-handed-inserter", pipe, "steam", 165)
local item = fluidInserterLib.createFluidInserterItem("burner-long-handed-inserter", "burner-long-handed-inserter", pipe, "steam")

entity = util.merge({entity,
	-- like long handed inserter
	rotation_speed = 0.02,
	extension_speed = 0.0457,
	-- halfway between burner inserter and electric inserter
	energy_per_movement = "30KJ",
	energy_per_rotation = "30KJ",
})

data:extend({entity, item,
	{
	  type = "recipe",
	  name = "pneumatic-long-handed-inserter",
	  enabled = false,
	  ingredients = {
		  {"wooden-gear-wheel", 1},
  	  {"gold-plate", 1},
	    {"pneumatic-inserter", 1}
  	},
	  results = {
      { type = "item", name = "pneumatic-long-handed-inserter", amount = 1 }
    }
	}
})
table.insert(unlockd_by_tech, name)

-- add a technology to unlock them
local tech = {
    type = "technology",
    name = "pneumatics",
    localised_name = {"technology-name.pneumatics"},
    localised_description = {"technology-description.pneumatics"},
    icon_size = 128,
    icon = "__pneumatic-inserter__/graphics/technology/pneumatics.png",
    effects = {},
    unit = {
      count = 20,
      ingredients = {
        {"wood-science-pack", 1},
        {"steam-science-pack", 1}
      },
      time = 10
    },
    prerequisites = {"gold-fluid-handling", "steam-automation"},
    order = "a-l"
  }
for _,recipe in ipairs(unlockd_by_tech) do
	table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = recipe
    })
end

data:extend({tech})



--[[
{
    type = "pipe",
    name = "pipe",
    icon = "__base__/graphics/icons/pipe.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "fast-replaceable-no-build-while-moving"},
    minable = {mining_time = 0.1, result = "pipe"},
    max_health = 100,
    corpse = "pipe-remnants",
    dying_explosion = "pipe-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "impact",
        percent = 30
      }
    },
    fast_replaceable_group = "pipe",
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fluid_box =
    {
      base_area = 1,
      pipe_connections =
      {
        { position = {0, -1} },
        { position = {1, 0} },
        { position = {0, 1} },
        { position = {-1, 0} }
      }
    },
    vehicle_impact_sound = sounds.generic_impact,
    pictures = pipepictures(),
    working_sound =
    {
      sound = sounds.pipe,
      match_volume_to_activity = true,
      audible_distance_modifier = 0.3,
      fade_in_ticks = 4,
      fade_out_ticks = 60
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    horizontal_window_bounding_box = {{-0.25, -0.28125}, {0.25, 0.15625}},
    vertical_window_bounding_box = {{-0.28125, -0.5}, {0.03125, 0.125}}
  },

  {
    type = "inserter",
    name = "inserter",
    icon = "__base__/graphics/icons/inserter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "inserter"},
    max_health = 150,
    corpse = "inserter-remnants",
    dying_explosion = "inserter-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    selection_box = {{-0.4, -0.35}, {0.4, 0.45}},
    damaged_trigger_effect = hit_effects.entity(),
    energy_per_movement = "5kJ",
    energy_per_rotation = "5kJ",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      drain = "0.4kW"
    },
    extension_speed = 0.03,
    rotation_speed = 0.014,
    fast_replaceable_group = "inserter",
    next_upgrade = "fast-inserter",
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.inserter_basic,
    hand_base_picture =
    {
      filename = "__base__/graphics/entity/inserter/inserter-hand-base.png",
      priority = "extra-high",
      width = 8,
      height = 33,
      hr_version =
      {
        filename = "__base__/graphics/entity/inserter/hr-inserter-hand-base.png",
        priority = "extra-high",
        width = 32,
        height = 136,
        scale = 0.25
      }
    },
    hand_closed_picture =
    {
      filename = "__base__/graphics/entity/inserter/inserter-hand-closed.png",
      priority = "extra-high",
      width = 18,
      height = 41,
      hr_version =
      {
        filename = "__base__/graphics/entity/inserter/hr-inserter-hand-closed.png",
        priority = "extra-high",
        width = 72,
        height = 164,
        scale = 0.25
      }
    },
    hand_open_picture =
    {
      filename = "__base__/graphics/entity/inserter/inserter-hand-open.png",
      priority = "extra-high",
      width = 18,
      height = 41,
      hr_version =
      {
        filename = "__base__/graphics/entity/inserter/hr-inserter-hand-open.png",
        priority = "extra-high",
        width = 72,
        height = 164,
        scale = 0.25
      }
    },
    hand_base_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
      priority = "extra-high",
      width = 8,
      height = 33,
      hr_version =
      {
        filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-base-shadow.png",
        priority = "extra-high",
        width = 32,
        height = 132,
        scale = 0.25
      }
    },
    hand_closed_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-closed-shadow.png",
      priority = "extra-high",
      width = 18,
      height = 41,
      hr_version =
      {
        filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-closed-shadow.png",
        priority = "extra-high",
        width = 72,
        height = 164,
        scale = 0.25
      }
    },
    hand_open_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-open-shadow.png",
      priority = "extra-high",
      width = 18,
      height = 41,
      hr_version =
      {
        filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-open-shadow.png",
        priority = "extra-high",
        width = 72,
        height = 164,
        scale = 0.25
      }
    },
    pickup_position = {0, -1},
    insert_position = {0, 1.2},
    platform_picture =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/inserter/inserter-platform.png",
        priority = "extra-high",
        width = 46,
        height = 46,
        shift = {0.09375, 0},
        hr_version =
        {
          filename = "__base__/graphics/entity/inserter/hr-inserter-platform.png",
          priority = "extra-high",
          width = 105,
          height = 79,
          shift = util.by_pixel(1.5, 7.5-1),
          scale = 0.5
        }
      }
    },
    circuit_wire_connection_points = circuit_connector_definitions["inserter"].points,
    circuit_connector_sprites = circuit_connector_definitions["inserter"].sprites,
    circuit_wire_max_distance = inserter_circuit_wire_max_distance,
    default_stack_control_input_signal = inserter_default_stack_control_input_signal
  },
  
  
data:extend({
  {
    type = "inserter",
    name = "burner-long-handed-inserter",
    icon = icon,
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "burner-long-handed-inserter"},
    max_health = 160,
    corpse = "burner-inserter-remnants",
    dying_explosion = "burner-inserter-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    selection_box = {{-0.4, -0.35}, {0.4, 0.45}},
    damaged_trigger_effect = hit_effects.entity(),
    pickup_position = {0, -2},
    insert_position = {0, 2.2},
    energy_per_movement = "50KJ",
    energy_per_rotation = "50KJ",
	extension_speed = 0.0354,
    rotation_speed = 0.014,
    hand_size = 1.5,
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 9
        }
      }
    },
    fast_replaceable_group = "long-handed-inserter",
	next_upgrade = "long-handed-inserter",
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.inserter_long_handed,
    hand_base_picture =
    {
      filename = "__base__/graphics/entity/long-handed-inserter/long-handed-inserter-hand-base.png",
      priority = "extra-high",
      width = 8,
      height = 34,
      hr_version =
      {
        filename = "__base__/graphics/entity/long-handed-inserter/hr-long-handed-inserter-hand-base.png",
        priority = "extra-high",
        width = 32,
        height = 136,
        scale = 0.25
      }
    },
    hand_closed_picture =
    {
      filename = "__base__/graphics/entity/long-handed-inserter/long-handed-inserter-hand-closed.png",
      priority = "extra-high",
      width = 18,
      height = 41,
      hr_version =
      {
        filename = "__base__/graphics/entity/long-handed-inserter/hr-long-handed-inserter-hand-closed.png",
        priority = "extra-high",
        width = 72,
        height = 164,
        scale = 0.25
      }
    },
    hand_open_picture =
    {
      filename = "__base__/graphics/entity/long-handed-inserter/long-handed-inserter-hand-open.png",
      priority = "extra-high",
      width = 18,
      height = 41,
      hr_version =
      {
        filename = "__base__/graphics/entity/long-handed-inserter/hr-long-handed-inserter-hand-open.png",
        priority = "extra-high",
        width = 72,
        height = 164,
        scale = 0.25
      }
    },
    hand_base_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
      priority = "extra-high",
      width = 8,
      height = 33,
      hr_version =
      {
        filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-base-shadow.png",
        priority = "extra-high",
        width = 32,
        height = 132,
        scale = 0.25
      }
    },
    hand_closed_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-closed-shadow.png",
      priority = "extra-high",
      width = 18,
      height = 41,
      hr_version =
      {
        filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-closed-shadow.png",
        priority = "extra-high",
        width = 72,
        height = 164,
        scale = 0.25
      }
    },
    hand_open_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-open-shadow.png",
      priority = "extra-high",
      width = 18,
      height = 41,
      hr_version =
      {
        filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-open-shadow.png",
        priority = "extra-high",
        width = 72,
        height = 164,
        scale = 0.25
      }
    },
    platform_picture =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/burner-inserter/burner-inserter-platform.png",
        priority = "extra-high",
        width = 46,
        height = 46,
        shift = {0.09375, 0},
        hr_version =
        {
          filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-platform.png",
          priority = "extra-high",
          width = 105,
          height = 79,
          shift = util.by_pixel(1.5, 7.5-1),
          scale = 0.5
        }
      }
    },
    circuit_wire_connection_points = circuit_connector_definitions["inserter"].points,
    circuit_connector_sprites = circuit_connector_definitions["inserter"].sprites,
    circuit_wire_max_distance = inserter_circuit_wire_max_distance,
    default_stack_control_input_signal = inserter_default_stack_control_input_signal
  },
  {
    type = "item",
    name = "burner-long-handed-inserter",
    icon = icon,
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "inserter",
    order = "ab[burner-long-handed-inserter]",
    place_result = "burner-long-handed-inserter",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "burner-long-handed-inserter",
    enabled = false,
    ingredients =
    {
      {"iron-gear-wheel", 1},
      {"iron-plate", 1},
      {"burner-inserter", 1}
    },
    result = "burner-long-handed-inserter"
  },
})
--]]