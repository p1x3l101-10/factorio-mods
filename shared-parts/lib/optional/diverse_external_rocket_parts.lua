local rocketItem = {} -- Create a class

function rocketItem:new(surface_name)
  local obj = {
    prototype = {
      type = "recipe",
      name = "rocket-part-" .. surface_name,
      localised_name = {"item-name.rocket-part"},
      localised_description = {"item-description.rocket-part"},
      icons = {
        { icon = "__base__/graphics/icons/rocket-part.png", icon_size=64 }
      },
      surface_conditions = {},
      energy_required = 3,
      enabled = false,
      hide_from_player_crafting = true,
      subgroup = "space-rocket",
      ingredients = {},
      results = {{type="item", name="rocket-part", amount=1}},
      allow_productivity = true,
      allow_quality = false
    },
    surfaceName = surface_name,
    ingredients = {
      raw = {},
      processed = {}
    },
    expensiveIngredients = {
      raw = {},
      processed = {}
    },
    planetImage = {
      image = {},
      added = false
    },
    surfaceConditions = {}
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function rocketItem:setIngredients(ingredients, expensiveIngredients)
  self.ingredients.raw = ingredients
  self.expensiveIngredients.raw = expensiveIngredients
  for _, ingredient in ipairs(ingredients) do
    local name = ingredient[1]
    local rawAmount = ingredient[2]
    local amount = rawAmount * settings.startup["external-rocket-part-cost-setting"].value
    table.insert(self.ingredients.processed, { type = "item", name = name, amount = amount })
  end
  for _, ingredient in ipairs(expensiveIngredients) do
    local name = ingredient[1]
    local rawAmount = ingredient[2]
    local amount = rawAmount * settings.startup["external-rocket-part-cost-setting"].value
    table.insert(self.expensiveIngredients.processed, { type = "item", name = name, amount = amount })
  end
  return self
end

function rocketItem:add_surfaceConditions(conditions)
  self.surfaceConditions = conditions
  return self
end

function rocketItem:addPlanetImage(imagePath, size)
  -- Can only do this once
  if not self.planetImage.added then
    self.planetImage.added = true
    if size ~= 64 then
      iconScale = 64/size/4
    else
      iconScale = 0.25
    end
    self.planetImage.image = { icon = imagePath, icon_size = size, scale = iconScale, shift = {-8,8} }
  end
  return self
end

function rocketItem:unlockedBy(tech_name)
  self.unlockedBy = tech_name
  return self
end

function rocketItem:setCrafter(category)
  self.category = category
  return self
end

function rocketItem:apply()
  -- Assemble the data
  if settings.startup["expensive-mode"].value then
    self.prototype.ingredients = self.expensiveIngredients.processed
  else
    self.prototype.ingredients = self.ingredients.processed
  end
  if self.surfaceConditions then
    self.prototype.surface_conditions = self.surfaceConditions
  end
  if self.category then
    self.prototype.category = self.category
  else
    self.prototype.category = "crafting"
  end
  self.prototype.category = self.category
  -- Add data to game
  data:extend({ self.prototype })
  local name = "rocket-part-" .. self.surfaceName
  if self.unlockedBy then
    table.insert(data.raw.technology[self.unlockedBy].effects,{ type = "unlock-recipe", recipe = name })
  end
  table.insert(data.raw.technology["rocket-part-productivity"].effects, { type = "change-recipe-productivity", recipe = name, change = 0.1 })
  -- Add handle that control script can see
  local serpent = require("serpent")
  local function getData(name)
    local proto = data.raw["entity-ghost"]["big-data-" .. name]
    if not proto then
      return {}
    end
    local function decode(data)
      if type(data) == "string" then
        return data
      end
      local str = {}
      for i = 2, #data do
        str[i - 1] = decode(data[i])
      end
      return table.concat(str, "")
    end
    local data = decode(proto.localised_description)
    local ok, copy = serpent.load(data)
    return copy
  end
  local planets = getData("DERP_Planet_Rockets")
  local bigpack = require("__big-data-string2__.pack")
  local encode = serpent.dump
  local function setData(name, data)
    return bigpack(name, encode(data))
  end
  table.insert(planets, self.surfaceName)
  data:extend({
    setData("DERP_Planet_Rockets", planets)
  })
end

return rocketItem