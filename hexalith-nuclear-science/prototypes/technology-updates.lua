local util = require("functions").tech

-- Make nuclear science a hexalith tech
util.add_prerequisite("uranium-mining", "planet-discovery-hexalith")
-- Redefine hexalith prereqs so that it fits in more
util.delete_prerequisite("planet-discovery-hexalith", "space-science-pack")
util.delete_prerequisite("planet-discovery-hexalith", "power-armor-mk2")
util.add_prerequisite("planet-discovery-hexalith", "space-platform-thruster")

-- Hide uranium until you go to hexalith
data.raw.recipe["uranium-ore"].enabled = false
local tech = data.raw.technology["uranium-mining"]
tech.effects[#tech.effects + 1 ] = { type = "unlock-recipe", recipe = "uranium-ore"}