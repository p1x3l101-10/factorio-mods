local silos_to_fix = {}

script.on_event(defines.events.on_built_entity, function(event)
    local entity = event.created_entity or event.entity
    if not entity.valid then return end

    if entity.name == "rocket-silo" then
        table.insert(silos_to_fix, {tick = game.tick + 1, entity = entity})
    end
end)

script.on_event(defines.events.on_tick, function(event)
    for i = #silos_to_fix, 1, -1 do
        local fix = silos_to_fix[i]
        if fix.tick <= game.tick then
            local entity = fix.entity
            if entity and entity.valid then
                entity.recipe_locked = false
                entity.set_recipe("rocket-part")
                entity.recipe_locked = true
            end
            table.remove(silos_to_fix, i)
        end
    end

    -- Disable the handler when no work is scheduled
    if #silos_to_fix == 0 then
        script.on_event(defines.events.on_tick, nil)
    end
end)

-- Only register on_tick when we actually need it
local function schedule_fix(entity)
    table.insert(silos_to_fix, {tick = game.tick + 1, entity = entity})
    script.on_event(defines.events.on_tick, function(event)
        for i = #silos_to_fix, 1, -1 do
            local fix = silos_to_fix[i]
            if fix.tick <= game.tick then
                local e = fix.entity
                if e and e.valid then
                    e.recipe_locked = false
                    e.set_recipe("rocket-part")
                    e.recipe_locked = true
                end
                table.remove(silos_to_fix, i)
            end
        end

        if #silos_to_fix == 0 then
            script.on_event(defines.events.on_tick, nil)
        end
    end)
end

-- Replace event registration with scheduler
script.on_event(defines.events.on_built_entity, function(event)
    local entity = event.created_entity or event.entity
    if not entity.valid then return end

    if entity.name == "rocket-silo" then
        schedule_fix(entity)
    end
end)
