--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 19:35
-- To change this template use File | Settings | File Templates.
--
local areas = {}
areas.map = {}
areas.roomOptions = {}
local function encodeDirs(l, r, u, d)

    return tostring(l) .. ":" .. tostring(r) .. ":" .. tostring(u) .. ":" .. tostring(d)
end

function genFun(i, j, k, m)
    return function(x, y)
        print(x, y)
        if not i then
            for z = 1, 32 do
                core.entity.add(scripts.entities.wall(x * 32, y * 32 + z))
            end
        end
        if not j then
            for z = 1, 32 do
                core.entity.add(scripts.entities.wall((x + 1) * 32, y * 32 + z))
            end
        end
        if not k then
            for z = 1, 32 do
                core.entity.add(scripts.entities.wall((x) * 32 + z, y * 32))
            end
        end
        if not m then
            for z = 1, 32 do
                core.entity.add(scripts.entities.wall((x) * 32 + z, (y + 1) * 32))
            end
        end
        return encodeDirs(i, j, k, m)
    end
end

function areas.generateRoomGenerators()
    for l = 1, 2 do
        for r = 1, 2 do
            for u = 1, 2 do
                for d = 1, 2 do
                    local i, j, k, m = l == 1, r == 1, u == 1, d == 1
                    local r = genFun(i, j, k, m)
                    areas.roomOptions[encodeDirs(i, j, k, m)] = areas.roomOptions[encodeDirs(i, j, k, m)] or {}
                    areas.roomOptions[encodeDirs(i, j, k, m)][#(areas.roomOptions[encodeDirs(i, j, k, m)]) + 1] = r
                end
            end
        end
    end
end

local function getneighbours(x, y, first)
    local l = areas.map[(x - 1) .. ":" .. y]
    local r = areas.map[(x + 1) .. ":" .. y]
    local u = areas.map[x .. ":" .. (y + 1)]
    local d = areas.map[x .. ":" .. (y - 1)]
    if not l and not r and not u and not d and not first then
        return false
    end
    if not l then
        l = math.random() > 0.2
    else
        l = not not l.r
    end
    if not r then
        r = math.random() > 0.2
    else
        r = not not r.l
    end
    if not u then
        u = math.random() > 0.2
    else
        u = not not u.d
    end
    if not d then
        d = math.random() > 0.2
    else
        d = not not d.u
    end

    return true, l, r, u, d
end

function areas.genArea(x, y, first)
    local t, l, r, u, d = getneighbours(x, y, first)
    if not t then
        return
    end
    pprint(areas.map)
    print(l, r, u, d)
    pprint(areas.roomOptions)
    r = areas.roomOptions[encodeDirs(l, r, u, d)][1]
    areas.map[x .. ":" .. y] = r(x, y)
end

function areas.update(_)
    local p = E.player[1]
    local x, y = math.floor(p.position.x / (32 * 32)), math.floor(p.position.y / (32 * 32))


    neigh = { { x = x + 1, y = y }, { x = x - 1, y = y }, { x = x, y = y + 1 }, { x = x, y = y - 1 }, { x = x + 1, y = y + 1 }, { x = x - 1, y = y - 1 }, { x = x - 1, y = y + 1 }, { x = x + 1, y = y - 1 } }
    for k, v in ipairs(neigh) do
        if not areas.map[v.x .. ":" .. v.y] then
            areas.genArea(v.x, v.y)
        end
    end
end

return areas


