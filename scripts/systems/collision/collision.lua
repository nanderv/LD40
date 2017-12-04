-- Collision system
local s = {}
local bump = require 'lib.bump'
WORLD = bump.newWorld(50)
local lib = {}
s.functions = {}
s.circles = {}
s.boxes = {}
local rpo = {}
s.prev = {}
local a = 0
s.ray = function(entity1, from, to)
    local x3, y3, x4, y4 = entity1.position.x + from.x - to.x, entity1.position.y + from.y - to.y, entity1.position.x + to.x, entity1.position.y + to.y
    objs = WORLD:querySegment(x3, y3, x4, y4)


    for k, entity2 in ipairs(objs) do
        if entity1 ~= entity2 then

            local p2 = lib.rotate_poly(entity2)
            local d, x1, y1, x2, y2 = lib.line_in_polygon(p2, { x = from.x, y = from.y }, to, entity2.position, entity1.position)

            if d then
                a = a + 1
                x1 = x1 + entity2.position.x
                x2 = x2 + entity2.position.x
                y1 = y1 + entity2.position.y
                y2 = y2 + entity2.position.y
                local xr = ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) / ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4))
                local yr = ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) / ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4))

                return entity2, xr, yr
            end
        end
    end
    return nil
end
local function checkCollision(entity1)
    local shape1
    local x1, y1 = entity1.position.x, entity1.position.y
    if s.circles[entity1] then
        shape1 = s.circles[entity1]
    else
        shape1 = -s.boxes[entity1].minx
    end
    -- Use bump to check if entities are near enough. It uses either a circle around it or a box around it. The circle is rotation-safe, the box isn't.
    local _, _, cols, len = WORLD:move(entity1, entity1.position.x - shape1, entity1.position.y - shape1, function() return "cross" end)
    local dwarfBurnt = 0
    for _, b in ipairs(cols) do
        local entity2 = b.other
        if entity1 ~= entity2 then
            if entity1.player and entity2.collision.type == "wall" then
                s.prev[entity1].rotation = entity1.position.rotation
                entity1.position = s.prev[entity1]
            else

                -- Check if the collision is necessary. I think this is slightly slower than the previous check, so that's why this one is later. Not tested for speed.
                local collided = false
                if entity1.collision.type == "explosion" then
                    local dx = entity1.position.x - entity2.position.x
                    local dy = entity1.position.y - entity2.position.y

                    local dist = math.sqrt(dx*dx + dy*dy)
                    if entity2.hp then
                        entity2.dhp = (entity2.dhp or 0) +  math.max(100-dist, 0)
                    end
                    if entity2.player then
                        entity2.dhp = (entity2.dhp or 0)  + 300
                    end
                end
                if (entity2.collision.type == "dwarf" or entity2.collision.type == "explosive_dwarf") and entity1.collision.type == "fire" and dwarfBurnt < 2 then

                    local p1 = rpo[entity1]
                    if not p1 then
                        p1 = lib.rotate_poly(entity1)
                        rpo[entity1] = p1
                    end
                    collided = lib.point_in_polygon(p1, { x = 0, y = 0 }, entity1.position, entity2.position)
                    if collided then dwarfBurnt = dwarfBurnt + 1 end
                elseif lib.check_rule(entity1, entity2) then
                    local p1 = rpo[entity1]
                    if not p1 then
                        p1 = lib.rotate_poly(entity1)
                        rpo[entity1] = p1
                    end
                    local p2 = rpo[entity2]
                    if not p2 then
                        p2 = lib.rotate_poly(entity2)
                        rpo[entity2] = p2
                    end

                    -- polygon collision
                    collided = lib.polygon_in_polygon(p1, p2, entity1.position, entity2.position)
                    -- Actual logic
                end
                if collided then

                    lib.execute_if_rule(entity1, entity2, s.prev[entity1])
                end
            end
        end
    end
    s.prev[entity1] = { x = entity1.position.x, y = entity1.position.y, rotation = entity1.position.rotation }
end


s.functions.update = function(dt)
    rpo = {}
    for k, v in pairs(F.dynamic_collision) do

        checkCollision(v)
    end
    for k, v in pairs(F.moving_collision) do
        local shape1
        if s.circles[v] then
            shape1 = s.circles[v]
        else
            shape1 = -s.boxes[v].minx
        end
        WORLD:update(v, v.position.x - shape1, v.position.y - shape1)
    end
    for k, v in pairs(F.static_collision) do
        if v.collision.moved then
            checkCollision(v)
            v.collision.moved = nil
        end
    end
end

s.functions.reset = function()
    lib = scripts.systems.collision.lib
    lib.add_rule("fire", "dwarf",
        function(_, b)
            b.dhp = 60
        end)
    lib.add_rule("fire", "explosive_dwarf",
        function(_, b)
            b.dhp = 60
        end)
    lib.add_rule("fire", "spawner",
        function(_, b)
            b.dhp = 60
        end)
    lib.add_rule("dwarf", "player", function(_, b) b.hp = b.hp - 1 end)

    lib.add_rule("explosive_dwarf", "head", function(a, b)
        a.hp = 0
        while b.relativeto do
            b = b.relativeto
        end
    end)
    lib.add_rule("explosive_dwarf", "player", function(a, b)
        a.hp = 0
        while b.relativeto do
            b = b.relativeto
        end
        b.hp = b.hp - 30
    end)
    WORLD = bump.newWorld(50)
    s.circles = {}
    s.boxes = {}
    s.prev = {}
    rpo = {}
end
s.functions.preventWallCollision = function()
end

s.registers = {}
s.registers.collision = function(entity)
    if not entity.collision.box then
        local x, y, rad = lib.circle_around(entity, s.circles)
        WORLD:add(entity, x - rad, y - rad, rad * 2, rad * 2)
    else
        local x, y, minx, miny, maxx, maxy = lib.aabb_around(entity, s.boxes)
        WORLD:add(entity, x + minx, y + miny, maxx - minx, maxy - miny)
    end
    s.prev[entity] = { x = entity.position.x, y = entity.position.y, rotation = entity.position.rotation }
end


core.update_entity_collision_shape = function(entity)
    if not entity.collision.box then
        local x, y, rad = lib.circle_around(entity, s.circles)
        WORLD:add(entity, x - rad, y - rad, rad * 2, rad * 2)
    else
        local x, y, minx, miny, maxx, maxy = lib.aabb_around(entity, s.boxes)
        WORLD:add(entity, x + minx, y + miny, maxx - minx, maxy - miny)
    end
end

s.unregisters = {}
s.unregisters.collision = function(entity)
    s.circles[entity] = nil
    s.boxes[entity] = nil
    WORLD:remove(entity)
    s.prev[entity] = nil
end


return s
