local s = {}
s.functions = {}
local prevposses = {}

s.functions.update = function(dt)
    for k, v in ipairs(E.relative_position) do
        pprint("A")
        pprint(v.relativeto.position)
        pprint(v.position)
        pprint(prevposses[v])
        print(prevposses[v].x ~= v.relativeto.position.x)
        v.position.x, v.position.y = v.relativeto.position.x + v.position.x - prevposses[v].x, v.relativeto.position.y + v.position.y - prevposses[v].y
        local dr = v.position.rotation  - prevposses[v].rotation
        local dx, dty  = v.position.x - v.relativeto.position.x, v.position.y - v.relativeto.position.y

        v.position.rotation = v.position.rotation + v.relativeto.position.rotation - prevposses[v].rotation

        prevposses[v] = { x = v.relativeto.position.x, y = v.relativeto.position.y, rotation = v.relativeto.position.rotation }
    end
end

s.functions.reset = function()
    prevposses = {}
end
s.registers = {}
s.registers.relative_position = function(entity)
    local x = entity.position
    entity.position.x, entity.position.y, entity.position.rotation = x.x + entity.relativeto.position.x, x.y + entity.relativeto.position.y, x.rotation + entity.relativeto.position.rotation
    prevposses[entity] = { x = entity.relativeto.position.x, y = entity.relativeto.position.y, rotation = entity.relativeto.position.rotation }
end


s.unregisters = {}
s.unregisters.relative_position = function(entity)
    prevposses[entity] = nil
end

return s