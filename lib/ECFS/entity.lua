-- An entity is a single game-object. It should ALWAYS be data-only.
core.entity = {}

local unregisters = core.system.unregisters

core.entity._stack = {{}}

core.entity.add = function(ent, ...)
    local frame = core.entity._stack[#core.entity._stack]
    frame[#frame + 1] = ent

    core.filter.update(ent, ...)
end

function core.entity.push()
    core.entity._stack[#core.entity._stack + 1] = {}
end

function core.entity.pop()
    for k,v in ipairs(core.entity._stack[#core.entity._stack]) do
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

            for k,v in ipairs(frame) do
                if v == entity then
                    frame[k] = frame[#frame]
                    frame[#frame] = nil
                    found_in_frame = true
                    break
                end
            end
            if found_in_frame then break end
        end
    end

    local R = core.filter.rules
    for k, _ in pairs(entity) do
        entity[k] = nil
    end
    core.filter.update(entity)
end
