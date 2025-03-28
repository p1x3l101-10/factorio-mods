data:extend({
  {
    type = "recipe",
    name = "pneumatic-inserter",
    enabled = false,
    ingredients = {
      { "gold-pipe", 1 },
      { "gold-plate", 1 },
      { "burner-inserter", 1 }
    },
    results = {
      { type = "item", name = "pneumatic-inserter", amount = 1 }
    }
  },
  {
    type = "recipe",
    name = "pneumatic-long-handed-inserter",
    enabled = false,
    ingredients = {
      { "wooden-gear-wheel", 1 },
      { "gold-plate", 1 },
      { "pnumatic-inserter", 1 }
    },
    results = {
      { type = "item", name = "pneumatic-long-handed-inserter", amount = 1 }
    }
  }
})