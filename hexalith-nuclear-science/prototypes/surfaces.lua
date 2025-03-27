require("tiles")
--data.lua
local asteroid_util = require("__space-age__/prototypes/planet/asteroid-spawn-definitions")


--START MAP GEN
function MapGen_Hexalith()
    -- Nauvis-based generation
    local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)

    data:extend{
        {
          type = "noise-expression",
          name = "hexalith_enemy_base_radius",
          expression = "120"
        }
    }

    map_gen_setting.property_expression_names =
    {
        ["decorative:red-desert-bush:probability"] = "gleba_red_desert_bush_probability",
        ["decorative:white-desert-bush:probability"] = "gleba_white_desert_bush_probability",
        ["decorative:red-pita:probability"] = "gleba_red_pita_probability",
        ["decorative:green-bush-mini:probability"] = "gleba_green_bush_probability",
        ["decorative:green-croton:probability"] = "gleba_green_cronton_probability",
        ["decorative:green-pita:probability"] = "gleba_green_pita_probability",
        ["decorative:green-pita-mini:probability"] = "gleba_green_pita_mini_probability",
        ["decorative:lichen-decal:probability"] = "gleba_orange_lichen_probability",
        ["decorative:shroom-decal:probability"] = "gleba_carpet_shroom_probability",
        ["decorative:cracked-mud-decal:probability"] = "gleba_cracked_mud_probability",
        ["decorative:light-mud-decal:probability"] = "gleba_light_mud_probability",
        ["decorative:dark-mud-decal:probability"] = "gleba_dark_mud_probability",
        ["decorative:green-carpet-grass:probability"] = "gleba_green_carpet_grass_probability",
        ["decorative:green-hairy-grass:probability"] = "gleba_green_hairy_grass_probability"
    }
    map_gen_setting.property_expression_names.starting_area_radius = "hexalith_enemy_base_radius"
    map_gen_setting.property_expression_names.cliffiness = "cliffiness_basic"
    map_gen_setting.property_expression_names.cliff_elevation = "cliff_elevation_from_elevation"
    
    map_gen_setting.cliff_settings =
    {
      name = "cliff",
      control = "nauvis_cliff",
      cliff_smoothing = 0
    }

    map_gen_setting.autoplace_controls = {
        
        ["enemy-base"] = { frequency = 20, size = 7, richness = 7},
        ["trees"] = { frequency = 0.5, size = 0.5, richness = 1 },
        ["rocks"] = { frequency = 2, size = 1, richness = 1},
        ["gleba_water"] = {frequency = 0.4, size = 0.5, richness = 0.5},
        ["water"] = { frequency = 1, size = 1, richness = 1 },
        ["uranium-ore"] = { frequency = 25, size = 5, richness = 0.5},
        ["nauvis_cliff"] = { frequency = 4, size = 1, richness = 1},
    }

    map_gen_setting.autoplace_settings["tile"] =
    {
        settings =
        {
            ["mickora_grass-1"] = {},
            ["mickora_grass-2"] = {},
            ["dry-dirt"] = {},
            ["dirt-1"] = {},
            ["dirt-2"] = {},
            ["dirt-3"] = {},
            ["dirt-4"] = {},
            ["dirt-5"] = {},
            ["dirt-6"] = {},
            ["dirt-7"] = {},
            ["sand-1"] = {},
            ["sand-2"] = {},
            ["sand-3"] = {},
            ["red-desert-0"] = {},
            ["red-desert-1"] = {},
            ["red-desert-2"] = {},
            ["red-desert-3"] = {},
            ["grass-1"] = {},
            ["grass-2"] = {},
            ["grass-3"] = {},
            ["grass-4"] = {},
            ["fulgoran-machinery"] = {},
            ["gleba-deep-lake"] = {},
            ["lowland-brown-blubber"] = {},
            ["lowland-olive-blubber"] = {},
            ["lowland-olive-blubber-2"] = {},
            ["lowland-olive-blubber-3"] = {},
            ["lowland-pale-green"] = {},
            ["lowland-cream-cauliflower"] = {},
            ["lowland-cream-cauliflower-2"] = {},
            ["lowland-dead-skin"] = {},
            ["lowland-dead-skin-2"] = {},
            ["lowland-cream-red"] = {},
            ["lowland-red-vein"] = {},
            ["lowland-red-vein-2"] = {},
            ["lowland-red-vein-3"] = {},
            ["lowland-red-vein-4"] = {},
            ["lowland-red-vein-dead"] = {},
            ["lowland-red-infection"] = {},
            ["midland-turquoise-bark"] = {},
            ["midland-turquoise-bark-2"] = {},
            ["midland-cracked-lichen"] = {},
            ["midland-cracked-lichen-dull"] = {},
            ["midland-cracked-lichen-dark"] = {},
            ["pit-rock"] = {}
        }
    }

    map_gen_setting.autoplace_settings["decorative"] =
    {
        settings =
        {
          ["brown-hairy-grass"] = {},
          ["brown-carpet-grass"] = {},
          ["green-small-grass"] = {},
          ["green-asterisk"] = {},
          ["fulgoran-ruin-tiny"] = {},
          ["fulgoran-gravewort"] = {},
          ["urchin-cactus"] = {},
          ["medium-fulgora-rock"] = {},
          ["small-fulgora-rock"] = {},
          ["tiny-fulgora-rock"] = {},
          ["yellow-lettuce-lichen-1x1"] = {},
          ["yellow-lettuce-lichen-3x3"] = {},
          ["yellow-lettuce-lichen-6x6"] = {},
          ["yellow-lettuce-lichen-cups-1x1"] = {},
          ["yellow-lettuce-lichen-cups-3x3"] = {},
          ["yellow-lettuce-lichen-cups-6x6"] = {},
          ["green-lettuce-lichen-1x1"] = {},
          ["green-lettuce-lichen-3x3"] = {},
          ["green-lettuce-lichen-6x6"] = {},
          ["green-lettuce-lichen-water-1x1"] = {},
          ["green-lettuce-lichen-water-3x3"] = {},
          ["green-lettuce-lichen-water-6x6"] = {},
          ["honeycomb-fungus"] = {},
          ["honeycomb-fungus-1x1"] = {},
          ["honeycomb-fungus-decayed"] = {},
          ["split-gill-1x1"] = {},
          ["split-gill-2x2"] = {},
          ["split-gill-dying-1x1"] = {},
          ["split-gill-dying-2x2"] = {},
          ["split-gill-red-1x1"] = {},
          ["split-gill-red-2x2"] = {},
          ["veins"] = {},
          ["veins-small"] = {},
          ["mycelium"] = {},
          ["coral-water"] = {},
          ["coral-land"] = {},
          ["black-sceptre"] = {},
          ["pink-phalanges"] = {},
          ["pink-lichen-decal"] = {},
          ["red-lichen-decal"] = {},
          ["green-cup"] = {},
          ["brown-cup"] = {},
          ["blood-grape"] = {},
          ["blood-grape-vibrant"] = {},
          ["brambles"] = {},
          ["polycephalum-slime"] = {},
          ["polycephalum-balloon"] = {},
          ["fuchsia-pita"] = {},
          ["wispy-lichen"] = {},
          ["grey-cracked-mud-decal"] = {},
          ["barnacles-decal"] = {},
          ["coral-stunted"] = {},
          ["coral-stunted-grey"] = {},
          ["nerve-roots-veins-dense"] = {},
          ["nerve-roots-veins-sparse"] = {},
          ["yellow-coral"] = {},
          ["solo-barnacle"] = {},
          ["curly-roots-orange"] = {},
          ["knobbly-roots"] = {},
          ["knobbly-roots-orange"] = {},
          ["matches-small"] = {},
          ["pale-lettuce-lichen-cups-1x1"] = {},
          ["pale-lettuce-lichen-cups-3x3"] = {},
          ["pale-lettuce-lichen-cups-6x6"] = {},
          ["pale-lettuce-lichen-1x1"] = {},
          ["pale-lettuce-lichen-3x3"] = {},
          ["pale-lettuce-lichen-6x6"] = {},
          ["pale-lettuce-lichen-water-1x1"] = {},
          ["pale-lettuce-lichen-water-3x3"] = {},
          ["pale-lettuce-lichen-water-6x6"] = {},
          ["white-carpet-grass"] = {},
          ["green-carpet-grass"] = {},
          ["green-hairy-grass"] = {},

          --shared
          ["light-mud-decal"] = {},
          ["dark-mud-decal"] = {},
          ["cracked-mud-decal"] = {},
          ["red-desert-bush"] = {},
          ["white-desert-bush"] = {},
          ["red-pita"] = {},
          ["green-bush-mini"] = {},
          ["green-croton"] = {},
          ["green-pita"] = {},
          ["green-pita-mini"] = {},
          ["lichen-decal"] = {},
          ["shroom-decal"] = {}
        }
    }

    map_gen_setting.autoplace_settings["entity"] =  { 
        settings =
        {
            ["fulgoran-ruin-vault"] = { frequency = 2, size = 2, richness = 2},
            ["fulgoran-ruin-colossal"] = { frequency = 2, size = 2, richness = 2},
            ["fulgoran-ruin-huge"] = { frequency = 2, size = 2, richness = 2},
            ["fulgoran-ruin-big"] = { frequency = 2, size = 2, richness = 2},
            ["fulgoran-ruin-stonehenge"] = { frequency = 2, size = 2, richness = 2},
            ["fulgoran-ruin-medium"] = { frequency = 2, size = 2, richness = 2},
            ["fulgoran-ruin-small"] = { frequency = 2, size = 2, richness = 2},
            ["fish"] = {},
            ["uranium-ore"] = {},
        }
    }

    return map_gen_setting
end
-- increse stone patch size in start area
-- data.raw["resource"]["stone"]["autoplace"]["starting_area_size"] = 5500 * (0.005 / 3)

--END MAP GEN

local nauvis = data.raw["planet"]["nauvis"]
local planet_lib = require("__PlanetsLib__.lib.planet")
local start_astroid_spawn_rate =
{
  probability_on_range_chunk =
  {
    {position = 0.1, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle},
    {position = 0.9, probability = asteroid_util.fulgora_chunks, angle_when_stopped = asteroid_util.chunk_angle}
  },
  type_ratios =
  {
    {position = 0.1, ratios = asteroid_util.nauvis_ratio},
    {position = 0.9, ratios = asteroid_util.fulgora_ratio},
  }
}
local start_astroid_spawn = asteroid_util.spawn_definitions(start_astroid_spawn_rate, 0.1)


local hexalith= 
{
    type = "planet",
    name = "hexalith", 
    solar_power_in_space = nauvis.solar_power_in_space,
    icon = "__hexalith-nuclear-science__/graphics/technology/hexalith.png",
    icon_size = 512,
    label_orientation = 0.55,
    starmap_icon = "__hexalith-nuclear-science__/graphics/technology/hexalith.png",
    starmap_icon_size = 512,
    magnitude = nauvis.magnitude,
    subgroup = "planets",
    surface_properties = {
        ["solar-power"] = 100,
        ["pressure"] = nauvis.surface_properties["pressure"],
        ["magnetic-field"] = nauvis.surface_properties["magnetic-field"],
        ["day-night-cycle"] = nauvis.surface_properties["day-night-cycle"],
        ["gravity"] = 12,
    },
    surface_render_parameters =
    {
        day_night_cycle_color_lookup = {
            {0.0, "identity"},
            {0.35, "__core__/graphics/color_luts/night.png"},
        }
    },
    map_gen_settings = MapGen_Hexalith(),
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = start_astroid_spawn,
    pollutant_type = "pollution",
}

hexalith.orbit = {
    parent = {
        type = "space-location",
        name = "star",
    },
    distance = 17,
    orientation = 0.42
}

local hexalith_connection = {
    type = "space-connection",
    name = "nauvis-hexalith",
    from = "nauvis",
    to = "hexalith",
    subgroup = data.raw["space-connection"]["nauvis-fulgora"].subgroup,
    length = 7000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_fulgora),
}

PlanetsLib:extend({hexalith})
PlanetsLib.borrow_music(data.raw["planet"]["nauvis"], hexalith)

data:extend{hexalith_connection}

data:extend {{
    type = "technology",
    name = "planet-discovery-hexalith",
    icons = PlanetsLib.technology_icon_constant_planet("__hexalith-nuclear-science__/graphics/technology/hexalith.png", 512),
    icon_size = 512,
    essential = true,
    localised_description = {"space-location-description.hexalith"},
    effects = {
        {
            type = "unlock-space-location",
            space_location = "hexalith",
            use_icon_overlay_constant = true
        },
    },
    prerequisites = {
        "space-science-pack", "power-armor-mk2",
    },
    unit = {
        count = 200,
        ingredients = {
            {"automation-science-pack",      1},
            {"logistic-science-pack",        1},
            {"chemical-science-pack",        1},
            {"space-science-pack",           1}
        },
        time = 60,
    },
    order = "ea[hexalith]",
}}