local util = require("functions").entity

-- Add back science recipies to burner assembler
util.add_crafting_category("assembling-machine", "burner-assembling-machine", "centrifuging-or-crafting")
util.add_crafting_category("assembling-machine", "burner-assembling-machine", "advanced-centrifuging-or-crafting")

-- Remove complex recipies from handcrafting
util.remove_crafting_category("character", "character", "centrifuging-or-crafting")
util.remove_crafting_category("character", "character", "advanced-centrifuging-or-crafting")