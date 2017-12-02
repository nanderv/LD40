--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 18:57
-- To change this template use File | Settings | File Templates.
--

local ctx = GS.new()
local input = { text = "" }

function ctx:enter()

    require 'scripts'
    scripts.systems.map.areas.genAll()

    scripts.systems.map.areas.genArea(0, 0, true)
    GS.push(scripts.gamestates.overworld)
    scripts.systems.collision.collision.functions.reset()
    core.system.add(scripts.systems.collision.collision)
    core.system.add(scripts.systems.map.map)
    core.system.add(scripts.systems.helpers.relative_position)

    core.entity.add(scripts.entities.camera(0,0))
    local ent = scripts.entities.dragon(0.5*32*16,32*20.5*16, 0)
    local neck = scripts.entities.dragonNeck(true, ent)
    core.entity.add(neck)
    neck = scripts.entities.dragonNeck(false, ent)
    core.entity.add(neck)
    local head = scripts.entities.dragonHead(neck)
    core.entity.add(head)

    E.currentframe = 0
    local spread = 200
    for i = 1, 1 do
        core.entity.add(scripts.entities.dwarf(0.5*32*16-spread + math.random(spread*2), 32*20.5*16-spread + math.random(spread*2), 0))
    end
    core.entity.add(ent)
    core.entity.add(HOARD)
    local h1 = core.newHandler("mouse", function(event) return event.type=="mouseclick" end, {type = "list"})

    -- Hoard
    ent = { money = { total = 0, lastgiven = 952, totalgiven = 0, lastleft = 0, pocket_treasure = 0 }, son = { happy_this_turn = false }, current_turn_len = 0, current_second_progress = 0, in_raid = false, raid_level = 1 }
    core.entity.add(ent)

    rh.register()
end



function ctx:update(dt)
    E.currentframe = E.currentframe + 1
    scripts.main.mainloop(dt)
    suit.layout:reset((love.graphics.getWidth() / 3) * 2, 33)
    suit.Slider({ value = E.hoard[1].current_turn_len, min = 0, max = 120 }, { id = 'Day progress', valign = "bottom" }, suit.layout:row(love.graphics.getWidth() / 3, 15))
    suit._instance:registerDraw(suit._instance.theme.Button, "", { id = "Chatbox", font = love.graphics.getFont(), valign = "top" }, -10, -10, love.graphics.getWidth() + 10, 55)
end


function ctx:draw()

    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", 0, 0, 10000, 10000)
    love.graphics.setColor(255, 255, 255)
    love.graphics.push()
    love.graphics.translate(scripts.systems.camera.toX(0), scripts.systems.camera.toY(0))
    scripts.systems.collision.debug_draw(dt)

    core.run("dwarf", scripts.systems.rendering.renderDwarf, { dt = dt })
    core.run("player", scripts.systems.rendering.renderDragon, { dt = dt })
    if DEBUGVALUE ~= nil then
        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(255, 0, 0)
        for _, x in pairs(DEBUGVALUE) do
            love.graphics.line(unpack(x))
        end
        love.graphics.setColor(r, g, b, a)
    end
    love.graphics.pop()
    suit.draw()
    core.run("hoard", scripts.systems.money.money.show_money, {})

    if DEBUG then
        love.graphics.print(love.timer.getFPS(), 10, 30)
        love.graphics.print(collectgarbage('count'), 50, 30)
    end
end


function ctx:leave()
    love.mouse.setGrabbed(false)
    print('leaving')
end
return ctx
