-- An entity is a single game-object. It should ALWAYS be data-only.
core.entity = {}

local unregisters = core.system.unregisters

-- This is awesome. Think about it, you will understand why ;).
core.entity.add = core.filter.update

function core.entity.remove(entity)
    local R = core.filter.rules
    for k, _ in pairs(entity) do
        entity[k] = nil
    end
    core.filter.update(entity)
end
