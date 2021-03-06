--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 19:35
-- To change this template use File | Settings | File Templates.
--
local astray = require 'lib.astray'
local areas = {}
local symbols = { Wall = '#', Empty = ' ', DoorN = ' ', DoorS = ' ', DoorE = ' ', DoorW = ' ' }
areas.map = {}
areas.roomOptions = {}
local locs = {}
local ll = { 4, 8, 16 }
for _, v in ipairs(ll) do
    for _, w in ipairs(ll) do
        locs[#locs + 1] = { x = v, y = w }
    end
end
pprint(locs)
local spawnPatterns = {}
spawnPatterns[1] = {}
spawnPatterns[2] = { locs[5] }
spawnPatterns[3] = { locs[2], locs[8] }
spawnPatterns[4] = { locs[2], locs[5], locs[8] }
spawnPatterns[5] = { locs[4], locs[5], locs[6] }
spawnPatterns[6] = { locs[1], locs[3], locs[7], locs[9] }
spawnPatterns[7] = locs
local roomsGenerated = 1
local currentPattern = 1
local mult = 1
local grass = "grass"
local grounds = { "ground", "ground2", "ground3", "ground4" }
local middles = { "middle", "middle2" }
local wall = { "testmap" }
function areas.genAll()
    local height, width = 40, 40
    --	Astray:new(width/2-1, height/2-1, changeDirectionModifier (1-30), sparsenessModifier (25-70), deadEndRemovalModifier (70-99) ) | RoomGenerator:new(rooms, minWidth, maxWidth, minHeight, maxHeight)
    local generator = astray.Astray:new(height / 2 - 1, width / 2 - 1, 30, 70, 50, astray.RoomGenerator:new(4, 2, 4, 2, 4))

    local dungeon = generator:Generate()

    local tiles = generator:CellToTiles(dungeon, symbols)
    for y = 0, #tiles[1] do

        for x = 0, #tiles do
            areas.map[x .. ":" .. y] = tiles[y][x]
        end
    end
    local x = 0
    local y = 20
    while areas.map[x .. ":" .. y] ~= " " do
        areas.map[x .. ":" .. y] = " "
        x = x + 1
    end
    for i=1,40 do
        core.entity.add(scripts.entities.ground(-1, i, grass))
        core.entity.add(scripts.entities.ground(-2, i, grass))
        core.entity.add(scripts.entities.ground(41, i, grass))
        core.entity.add(scripts.entities.ground(i, -1, grass))
        core.entity.add(scripts.entities.ground(i, 41, grass))
        core.entity.add(scripts.entities.ground(i, 42, grass))
    end

    for y = 0, #tiles[1] do
        local line = ''
        for x = 0, #tiles do
            line = line .. areas.map[x .. ":" .. y]
            if areas.map[x .. ":" .. y] == "#" then
                if areas.map[x .. ":" .. y + 1] == "#" then
                    core.entity.add(scripts.entities.wall(x, y, middles[math.random(#middles)]))
                else
                    core.entity.add(scripts.entities.wall(x, y, wall[math.random(#wall)]))
                end
            else
                core.entity.add(scripts.entities.ground(x, y, grounds[math.random(#grounds)]))
            end
        end
        print(line)
    end
end

function areas.genArea(x, y, first)
    if x == 1 and y == 20 or math.random() > 0.5 then
        areas.map[x .. ":" .. y] = "_"
        return
    end
    roomsGenerated = roomsGenerated + 1
    for k, v in pairs(spawnPatterns[currentPattern]) do
        -- Spawn Spawner
        print("SPAWN" , roomsGenerated)
        if roomsGenerated > 8 then
            local num = math.random()
            if num > 0.9 then
                core.entity.add(scripts.entities.ballista(32 * v.x + x * 32 * 20, 32 * v.y + y * 32 * 20, math.pi / 2, 1, 100, 100, 500, 20))
            elseif num > 0.75 then
                core.entity.add(scripts.entities.dwarf_spawner(32 * v.x + x * 32 * 20, 32 * v.y + y * 32 * 20, math.pi / 2, "explosive_dwarf", 5 * #spawnPatterns[currentPattern] / math.sqrt(roomsGenerated), 40, 200))
            else
                core.entity.add(scripts.entities.dwarf_spawner(32 * v.x + x * 32 * 20, 32 * v.y + y * 32 * 20, math.pi / 2, "dwarf", 3 * #spawnPatterns[currentPattern] / math.sqrt(roomsGenerated), 40, 100))
            end
        else
            core.entity.add(scripts.entities.dwarf_spawner(32 * v.x + x * 32 * 20, 32 * v.y + y * 32 * 20, math.pi / 2, "dwarf", 3 * #spawnPatterns[currentPattern] / math.sqrt(roomsGenerated), 40, 100))
        end
    end
    currentPattern = currentPattern + mult
    while currentPattern > #spawnPatterns do
        currentPattern = currentPattern - #spawnPatterns
    end
    mult = mult + 5
    areas.map[x .. ":" .. y] = "_"
end

function areas.update(_)
    local p = core.filter.get("player")
    local x, y = math.floor(p.position.x / (32 * 20)), math.floor(p.position.y / (32 * 20))
    areas.map[x .. ":" .. y] = "A"

    neigh = { { x = x + 1, y = y }, { x = x - 1, y = y }, { x = x, y = y + 1 }, { x = x, y = y - 1 } }
    for k, v in ipairs(neigh) do
        if areas.map[v.x .. ":" .. v.y] == " " then
            areas.genArea(v.x, v.y)
        end
    end
end

return areas


