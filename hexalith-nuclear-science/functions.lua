-- Add the base functions so I can extend them
local M1 = require("__atan-nuclear-science__/functions")

local M = {
  entity = M1.entity,
  item = M1.item,
  recipe = M1.recipe,
  tech = M1.tech,
  misc = {},
}

function M.misc.getIndex(array, value)
  for i, v in ipairs(array) do
    if v == value then
      return i
    end
  end
  return nil
end

function M.entity.remove_crafting_category(entity_type, entity_name, category)
  if not data.raw[entity_type] then
    return
  end
  if not data.raw[entity_type][entity_name] then
    return
  end
  local entity = data.raw[entity_type][entity_name]
  if entity.crafting_categories then
    local index = M.misc.getIndex(entity.crafting_categories, category)
    table.remove(entity.crafting_categories, index)
  end
end

function M.tech.unmake_essential(tech_name)
  if not data.raw["technology"][tech_name] then
    return
  end
  data.raw["technology"][tech_name].essential = false
end

function M.tech.disable_tech(tech_name)
  if not data.raw["technology"][tech_name] then
    return
  end
  data.raw["technology"][tech_name].enabled = false
  data.raw["technology"][tech_name].hidden = true
end

return M