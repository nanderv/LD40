DEBUG = false

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


pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'
rh = require 'scripts.handlers.registerHandlers'
suit = require 'lib.suit'

HOARD = { money = { total = 0, lastgiven = 952, totalgiven = 0, lastleft = 0, pocket_treasure = 0 }, son = { happy_this_turn = false }, current_turn_len = 0, current_second_progress = 0, in_raid = true, raid_level = 1 }

function love.load()
    GS.registerEvents()
    GS.switch(scripts.gamestates.game)
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