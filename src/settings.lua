data:extend({
  {
    type = "bool-setting",
    name = "hexalith-nuclear-science-peaceful-nauvis",
    setting_type = "startup",
    default_value = true
  },
  {
    type = "string-setting",
    name = "hexalith-nuclear-science-hexalith-difficulty",
    setting_type = "startup",
    default_value = "easy",
    allowed_values = { "original", "easy", "baby"}
    -- Anything below original will add crude oil to hexalith, and lower starting evolution
    -- for players of the non-masochistic variety who want to be able to function without too many imports
    -- the fact that fish and wood are there means that gleba techs let you have a self-sufficiant base (bacteria etc.)
  }
})