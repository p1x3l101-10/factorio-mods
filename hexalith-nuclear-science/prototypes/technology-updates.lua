local util = require("functions").tech

-- Make nuclear science a hexalith tech
util.add_prerequisite("uranium-mining", "planet-discovery-hexalith")
-- Redefine hexalith prereqs so that it fits in more
util.delete_prerequisite("planet-discovery-hexalith", "space-science-pack")
util.delete_prerequisite("planet-discovery-hexalith", "power-armor-mk2")
util.add_prerequisite("planet-discovery-hexalith", "space-platform-thruster")