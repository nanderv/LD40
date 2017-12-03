--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 19:35
-- To change this template use File | Settings | File Templates.
--
local astray = require 'lib.astray'
local areas = {}
local symbols = {Wall='#', Empty=' ', DoorN=' ', DoorS=' ', DoorE=' ', DoorW=' '}
areas.map = {}
areas.roomOptions = {}
function areas.genAll()
    local height, width = 40, 40
    --	Astray:new(width/2-1, height/2-1, changeDirectionModifier (1-30), sparsenessModifier (25-70), deadEndRemovalModifier (70-99) ) | RoomGenerator:new(rooms, minWidth, maxWidth, minHeight, maxHeight)
    local generator = astray.Astray:new( height/2-1, width/2-1, 30, 70, 50, astray.RoomGenerator:new(4, 2, 4, 2, 4) )

    local dungeon = generator:Generate()

    local tiles = generator:CellToTiles( dungeon, symbols )
    for y = 0, #tiles[1] do

        for x = 0, #tiles do
            areas.map[x..":"..y] = tiles[y][x]

        end

    end
    local x = 0
    local y = 20
    while areas.map[x..":"..y] ~= " " do
        areas.map[x..":"..y] = " "
        x = x + 1
    end
    for y = 0, #tiles[1] do
        local line = ''
        for x = 0, #tiles do
            line = line .. areas.map[x..":"..y]
            if areas.map[x..":"..y] == "#" then
                core.entity.add(scripts.entities.wall(x,y))
            end
        end
        print(line)

    end
end
function areas.genArea(x, y, first)
    areas.map[x .. ":" .. y] = "_"
end

function areas.update(_)
    local p =core.filter.get("player")
    local x, y = math.floor(p.position.x / (32 * 32)), math.floor(p.position.y / (32 * 32))


    neigh = { { x = x + 1, y = y }, { x = x - 1, y = y }, { x = x, y = y + 1 }, { x = x, y = y - 1 } }
    for k, v in ipairs(neigh) do
        if areas.map[v.x .. ":" .. v.y] == " " then
            areas.genArea(v.x, v.y)
        end
    end
end

return areas


