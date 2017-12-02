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
    local ent = { LW = {}, collision = { dynamic = true, box = true, type = "test", polygon = { { x = -50, y = -50 }, { x = 50, y = -50 }, { x = 50, y = 500 }, { x = -50, y = 500 } } }, position = { x = 630, y = 290, rotation = 0 } }
    core.entity.add(ent)
    local ent = { clickable=true, mover=100,light = { minRot = 0, maxRot = 0.5 * math.pi, dist = 300 }, collision = { type = "test", box = true, polygon = { { x = -100, y = 0 }, { x = 0, y = 100 }, { x = 100, y = 0 }, { x = 0, y = -100 } }, dynamic = true }, position = { x = 250, y = 250, rotation = 0 } }
    core.entity.add(ent)

    ent = { collision = nil, position = { x = 250, y = 250, rotation = 0 }, wiskers = { { x = 100, y = 100 }, { x = -100, y = 100 } } }
    core.entity.add(ent)

    -- Hoard
    ent = { money = { total = 0, lastgiven = 950, totalgiven = 0, lastleft = 0, pocket_treasure = 0 }, son = { happy_this_turn = false }, current_turn_len = 0, current_second_progress = 0, in_raid = false, raid_level = 1 }
    core.entity.add(ent)

    -- Give to son
    ent = { name="Give to son", position = { x = 500, y = 0, rotation = 0 }, clickable = true, collision = { type = "nd", box = true, polygon = { { x = 0, y = 0 }, { x = 0, y = 50 }, { x = 50, y = 50 }, { x = 50, y = 0 } } } }
    core.entity.add(ent)
    ent = { name = "Open chest", position = { x = 500, y = 55, rotation = 0 }, clickable = true, collision = { type = "nd", box = true, polygon = { { x = 0, y = 0 }, { x = 0, y = 50 }, { x = 50, y = 50 }, { x = 50, y = 0 } } } }
    core.entity.add(ent)
    ent = { name = "Next day", position = { x = 500, y = 110, rotation = 0 }, clickable = true, collision = { type = "nd", box = true, polygon = { { x = 0, y = 0 }, { x = 0, y = 50 }, { x = 50, y = 50 }, { x = 50, y = 0 } } } }
    core.entity.add(ent)
    ent = { name = "End raid", position = { x = 500, y = 165, rotation = 0 }, clickable = true, collision = { type = "nd", box = true, polygon = { { x = 0, y = 0 }, { x = 0, y = 50 }, { x = 50, y = 50 }, { x = 50, y = 0 } } } }
    core.entity.add(ent)

    rh.register()

    pprint(core.findHandler("test"))

end

local input = { text = "" }

function love.update(dt)
    suit.layout:reset(550, 0)
    suit.Input(input, suit.layout:row(200,30))

    scripts.main.mainloop(dt, input.text)
end

function love.draw()
    scripts.systems.collision.debug_draw(dt)
    core.run("wiskers", scripts.systems.draw_wiskers, {dt=dt})
    core.run("hoard", scripts.systems.money.money.show_money, {})
    love.graphics.print(love.timer.getFPS(), 10, 10)
    love.graphics.print(collectgarbage('count'), 50, 10)
    suit.draw()
end

function love.mousepressed( x, y, button )
    core.runEvent({x = x, y = y, button = button, type = "mouseclick"})
end
function love.keypressed( key, scancode, isrepeat )
    suit.keypressed(key)
    core.runEvent({key=key, scancode=scancode,isrepeat=isrepeat,type="key"})
end

function love.textedited(text, start, length)
    -- for IME input
    suit.textedited(text, start, length)
end

function love.textinput(t)
    -- forward text input to SUIT
    suit.textinput(t)
end