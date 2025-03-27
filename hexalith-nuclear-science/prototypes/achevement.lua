local parts = require("__p1x3l101-shared-parts__/lib").graphics.achievement.parts

data:extend{
  -- Visit
  {
    type = "change-surface-achievement",
    name = "visit-hexalith",
    order = "a[progress]-g[visit-planet]-k[hexalith]",
    surface = "hexalith",
    icons = {
      parts.base("copper"),
    }
  },
  -- Research
  {
    type = "research-with-science-pack-achievement",
    name = "research-with-atoms",
    order = "e[research]-a[research-with]-i[atoms]",
    science_pack = "nuclear-science-pack",
    icons = {
      parts.base("copper"),
    }
  }
  -- NOTE: If nuclear science adds its own achievement, decide if I should remove it or if I should migrate mine to theirs
}