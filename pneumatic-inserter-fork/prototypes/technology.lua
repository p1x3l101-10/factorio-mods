data:extend({
  {
    type = "technology",
    name = "pneumatics",
    icon_size = 128,
    icon = "__pneumatic-inserter-fork__/graphics/technology/pneumatics.png",
    effects = {
      { type = "unlock-recipe", recipe = "pneumatic-inserter" },
      { type = "unlock-recipe", recipe = "pneumatic-long-handed-inserter" }
    },
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
})