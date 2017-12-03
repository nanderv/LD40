local s = {}
s.functions = {}
local prevposses = {}

s.functions.update = function(dt)
    for k, v in pairs(F.relative_position) do
        v.position.x, v.position.y = v.relativeto.position.x + v.position.x - prevposses[v].x, v.relativeto.position.y + v.position.y - prevposses[v].y
        local dr = v.relativeto.position.rotation - prevposses[v].rotation
        local po = {x=v.position.x - v.relativeto.position.x, y= v.position.y - v.relativeto.position.y}
        local p   = core.rotate_point(po, dr)

        v.position.x = v.position.x + p.x - po.x
        v.position.y = v.position.y + p.y - po.y

        v.position.rotation = v.position.rotation + (v.relativeto.position.rotation - prevposses[v].rotation)
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