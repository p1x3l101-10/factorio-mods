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

function M.recipe.has_ingredient(recipe_name, ingredient_name)
  local recipe = data.raw["recipe"][recipe_name]
  if not recipe then return end
  for _, extant in pairs(recipe.ingredients) do
    if extant["name"] == ingredient_name then
        return true
    end
  end
  return false
end

function M.recipe.add_ingredient(recipe_name, ingredient)
  local recipe = data.raw["recipe"][recipe_name]
  if not recipe then return end
  if M.recipe.has_ingredient(recipe_name, ingredient["name"]) then return end
  recipe.ingredients[#recipe.ingredients + 1] = ingredient
end

function M.recipe.delete_ingriedent(recipe_name, ingredient_name)
  local recipe = data.raw["recipe"][recipe_name]
  if not recipe then return end
  if not M.recipe.has_ingredient(recipe_name, ingredient_name) then return end
  local deleted = false
  local new_ingredients = {}
  for _, ingredient in pairs(recipe.ingredients) do
    if ingredient["name"] == ingredient_name then
      deleted = true
    else
      new_ingredients[#new_ingredients + 1] = ingredient
    end
  end
  if deleted then
    recipe.ingredients = new_ingredients
  end
end

function M.recipe.set_surface_conditions(recipe_name, surface_conditions)
  local recipe = data.raw["recipe"][recipe_name]
  if not recipe then return end
  recipe.surface_conditions = surface_conditions
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