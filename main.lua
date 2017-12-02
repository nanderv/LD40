pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'
rh = require 'scripts.handlers.registerHandlers'
suit = require 'lib.suit'

function love.load()
    require 'scripts'
    scripts.systems.collision.collision.functions.reset()
    core.system.add(scripts.systems.collision.collision)
    core.system.add(scripts.systems.map.map)
    core.system.add(scripts.systems.helpers.relative_position)

    core.entity.add(scripts.entities.camera(0,0))
    local ent = scripts.entities.dragon(600,600, 0)
    core.entity.add(ent)
    core.entity.add(scripts.entities.dragonHead(ent))
    local h1 = core.newHandler("mouse", function(event) return event.type=="mouseclick" end, {type = "list"})

    -- Hoard
    ent = { money = { total = 0, lastgiven = 952, totalgiven = 0, lastleft = 0, pocket_treasure = 0 }, son = { happy_this_turn = false }, current_turn_len = 0, current_second_progress = 0, in_raid = false, raid_level = 1 }
    core.entity.add(ent)

    rh.register()

    core.entity.add(scripts.entities.wall(1,1))
    core.entity.add(scripts.entities.wall(5,5))

end

local input = { text = "" }

function love.update(dt)
    if not scripts.systems.money.money.get_money_ent().in_raid then

        suit.layout:reset((love.graphics.getWidth() / 2) - 150, 200)
        suit.layout:padding(5)
        suit.layout:push(suit.layout:row(300, 30))
        suit.Input(input, suit.layout:col(200, 30))
        if suit.Button("Give to son", suit.layout:col(95, 30)).hit then
            scripts.systems.money.money.debug_button(0)
        end
        suit.layout:pop()
        if suit.Button("Begin raid", suit.layout:row()).hit then
            scripts.systems.money.money.debug_button(3)
        end
        if suit.Button("Next day", suit.layout:row()).hit then
            scripts.systems.money.money.debug_button(2)
        end
    end

    scripts.main.mainloop(dt, input.text)
end

function love.draw()

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

function love.mousepressed(x, y, button)
    core.runEvent({ x = x, y = y, button = button, type = "mouseclick" })
end

function love.keypressed(key, scancode, isrepeat)
    suit.keypressed(key)
    core.runEvent({ key = key, scancode = scancode, isrepeat = isrepeat, type = "key" })
end

function love.textedited(text, start, length)
    -- for IME input
    suit.textedited(text, start, length)
end

function love.textinput(t)
    -- forward text input to SUIT
    suit.textinput(t)
end