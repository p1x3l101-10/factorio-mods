data:extend({
  {
    type = "recipe",
    name = "pneumatic-inserter",
    enabled = false,
    ingredients = {
      { type = "item", name = "gold-pipe",       amount = 1 },
      { type = "item", name = "gold-plate",      amount = 1 },
      { type = "item", name = "burner-inserter", amount = 1 }
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
      { type = "item", name = "wooden-gear-wheel", amount = 1 },
      { type = "item", name = "gold-plate",        amount = 1 },
      { type = "item", name = "pnumatic-inserter", amount = 1 }
    },
    results = {
      { type = "item", name = "pneumatic-long-handed-inserter", amount = 1 }
    }
  }
})