local util = require("functions").tech

-- Remove nuclear science from needed tech for legendary, it is a T3 planet too
util.delete_ingredient(data.raw.technology["legendary-quality"], "nuclear-science-pack")