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
    GS.push(scripts.gamestates.overworld)
    scripts.systems.collision.collision.functions.reset()
    core.system.add(scripts.systems.collision.collision)
    core.system.add(scripts.systems.map.map)
    core.system.add(scripts.systems.helpers.relative_position)

    core.entity.add(scripts.entities.camera(0,0))
    local ent = scripts.entities.dragon(600,600, 0)
    core.entity.add(ent)
    core.entity.add(BOARD)
    core.entity.add(scripts.entities.dragonHead(ent))
    local h1 = core.newHandler("mouse", function(event) return event.type=="mouseclick" end, {type = "list"})

    -- Hoard
    ent = { money = { total = 0, lastgiven = 952, totalgiven = 0, lastleft = 0, pocket_treasure = 0 }, son = { happy_this_turn = false }, current_turn_len = 0, current_second_progress = 0, in_raid = false, raid_level = 1 }
    core.entity.add(ent)

    rh.register()

    core.entity.add(scripts.entities.wall(1,1))
    core.entity.add(scripts.entities.wall(5,5))
end



function ctx:update(dt)
    scripts.main.mainloop(dt, input.text)
end


function ctx:draw()

    love.graphics.setColor(0,0,255)
    love.graphics.rectangle("fill",0,0,10000,10000)
    love.graphics.setColor(255,255,255)
    love.graphics.push()
    love.graphics.translate( scripts.systems.camera.toX(0), scripts.systems.camera.toY(0) )
    core.run("player", scripts.systems.rendering.renderDragon, { dt = dt })

    scripts.systems.collision.debug_draw(dt)

    love.graphics.pop()
    core.run("hoard", scripts.systems.money.money.show_money, {})

    suit.draw()
    love.graphics.print(love.timer.getFPS(), 10, 30)
    love.graphics.print(collectgarbage('count'), 50, 30)
end


function ctx:leave()
    love.mouse.setGrabbed(false)
    print('leaving')
end
return ctx