data:extend
({
  {
    type = "technology",
    name = "uncommon-quality",
    icon = "__quality__/graphics/technology/epic-quality.png", -- placeholder
    --icon = "__unlockable-qualities__/graphics/technology/uncommon.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-quality",
        quality = "uncommon"
      }
    },
    prerequisites = { "quality-module" },
    unit = {
      count = 500,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack",   1}
      },
      time = 30
    }
  }
  {
    type = "technology",
    name = "rare-quality",
    icon = "__quality__/graphics/technology/epic-quality.png", -- placeholder
    --icon = "__unlockable-qualities__/graphics/technology/rare.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-quality",
        quality = "rare"
      }
    },
    prerequisites = { "uncommon-quality" },
    unit = {
      count = 750,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack",   1},
        {"chemical-science-pack",   1}
      },
      time = 30
    }
  }
})

local epic_qual = data.raw.technology["epic-quality"].prerequisites
epic_qual[#epic_qual + 1] = { "rare-quality" }