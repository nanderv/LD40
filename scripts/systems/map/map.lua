--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 13:36
-- To change this template use File | Settings | File Templates.
--
local s = {}
s.map = {}
s.registers = {}
function s.get(x, y)
    return s.map[x .. ":" .. y]
end

SWIDTH = 32
s.pathFind = function(from, to)
    local neighbours = { from }
    local used = {}
    pprint(s.map)
    local here = 1
    while neighbours[here].x ~= to.x or neighbours[here].y ~= to.y do
        local obj = neighbours[here]

        local coords = { { x = obj.x, y = obj.y + 1 }, { x = obj.x, y = obj.y - 1 }, { x = obj.x + 1, y = obj.y }, { x = obj.x - 1, y = obj.y } }
        for _, coord in ipairs(coords) do
            local str = coord.x .. ":" .. coord.y
            if not s.map[str] and not used[str] then
                used[str] = true
                neighbours[#neighbours + 1] = coord
                coord.prev = obj
            end
        end
        local yd = { { x = obj.x, y = obj.y + 1 }, { x = obj.x, y = obj.y - 1 } }
        local xd = { { x = obj.x + 1, y = obj.y }, { x = obj.x - 1, y = obj.y } }
        for i=1, 4 do
            local xf = math.floor((i+1)/2 )
            local yf = i%2+1
            local cx = xd[xf]
            local cy = yd[yf]
            local rc  = {x=cx.x, y=cy.y }
            local str1 = cx.x..":".. cx.y
            local str2 = cy.x..":".. cy.y
            local str3 = rc.x..":".. rc.y
            if not s.map[str1] and not s.map[str2] and not s.map[str3] and not used[str3] then
                used[str3] = true
                neighbours[#neighbours+1] = rc
                rc.prev = obj
            end
        end
        here = here + 1
        if not neighbours[here] then
            return false
        end
    end
    local moi = neighbours[here]
    local route = {}
    while moi ~= nil do
        route[#route + 1] = moi
        moi = moi.prev
    end
    for i = 1, #route / 2 do
        route[i], route[#route - i] = route[#route - i], route[i]
    end
    return route
end
s.registers.mapPosition = function(entity)
    s.map[entity.mapPosition.x .. ":" .. entity.mapPosition.y] = entity
    entity.position.x = entity.mapPosition.x * SWIDTH
    entity.position.y = entity.mapPosition.y * SWIDTH
end
s.unregisters = {}
s.unregisters.mapPosition = function(entity)
    s.map[entity.mapPosition.x .. ":" .. entity.mapPosition.y] = nil
end

return s