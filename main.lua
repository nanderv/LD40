DEBUG = true
local music = love.audio.newSource(love.filesystem.newFile("assets/music/Exploding Bards.ogg"), "stream"):play()

GS = require "lib.gamestate"
love.math.setRandomSeed(love.timer.getTime())
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
love.math.random()
DEBUG=true

pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'
rh = require 'scripts.handlers.registerHandlers'
suit = require 'lib.suit'

HOARD = { money = { total = 0, lastgiven = 952, totalgiven = 0, lastleft = 0, pocket_treasure = 0 }, son = { happy_this_turn = false }, current_turn_len = 0, current_second_progress = 0, in_raid = false, raid_level = 1, last_turn_alive_or_new_day = true, dialog_status = nil }

function love.load()
    GS.registerEvents()
    core.entity.add(HOARD)
    GS.push(scripts.gamestates.textslide)
end

function love.mousepressed(x, y, button)
    core.runEvent({ x = x, y = y, button = button, type = "mouseclick" })
end

function love.keypressed(key, scancode, isrepeat)
    suit.keypressed(key)
    core.runEvent({ key = key, scancode = scancode, isrepeat = isrepeat, type = "key" })

    if DEBUG then
        if key == "c" then
            print("Collecting garbage")
            collectgarbage()
        end
    end
end

function love.textedited(text, start, length)
    -- for IME input
    suit.textedited(text, start, length)
end

function love.textinput(t)
    -- forward text input to SUIT
    suit.textinput(t)
end