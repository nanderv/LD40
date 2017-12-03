-- An entity is a single game-object. It should ALWAYS be data-only.
core.entity = {}

local unregisters = core.system.unregisters

core.entity._stack = { {} }

core.entity.add = function(ent, ...)
    if ent.player then pprint(ent) end
    local frame = core.entity._stack[#core.entity._stack]
    frame[ent] = ent

    core.filter.update(ent, ...)
end

function core.entity.push()
    core.entity._stack[#core.entity._stack + 1] = {}
end

function core.entity.pop()
    print("Hello!")
    for k, v in pairs(core.entity._stack[#core.entity._stack]) do

        if v.player then pprint(v) end
        core.entity.remove(v, k)
    end
    core.entity._stack[#core.entity._stack] = nil
end

function core.entity.remove(entity, idx, sf)
    if idx then
        local sf = core.entity._stack[sf or #core.entity._stack]
        sf[idx] = sf[#sf]
        sf[#sf] = nil
    else
        local found_in_frame = false
        for i = #core.entity._stack, 1, -1 do
            local frame = core.entity._stack[i]
            frame[entity] = nil
        end
    end

    local R = core.filter.rules

    for _, name_rules in pairs(R) do
        local name = name_rules[1]
        local ind = F[name][entity]

        if ind then
            F[name][entity] = nil

            if unregisters[name] then
                for _, v in pairs(unregisters[name]) do
                    v.unregisters[name](entity)
                end
            end
        end
    end
end
