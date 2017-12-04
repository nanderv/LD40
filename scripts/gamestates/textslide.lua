--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 04/12/2017
-- Time: 21:57
-- To change this template use File | Settings | File Templates.
--
local background_image = love.graphics.newImage("assets/images/backgrounds/background.png")

local ctx = GS.new()

local font
local font2
ctx.slide = 1
function ctx:enter()
    print("Entered " .. self.name)
    core.entity.push()
    font = love.graphics.newFont(56)
    font2 = love.graphics.newFont(40)
end

function ctx:update(dt)

end
local slides  = {}
slides[1] = function()
    local oldfont = love.graphics.getFont()
    love.graphics.draw(background_image,0,0,0,love.graphics.getWidth( )/background_image:getWidth(), love.graphics.getHeight()/background_image:getHeight())
    love.graphics.setFont(font)
    love.graphics.print("Your Gamename Could Be Here", 200, 200)
    love.graphics.setFont(oldfont)
end
slides[2] = function()
    local oldfont = love.graphics.getFont()
    love.graphics.draw(background_image,0,0,0,love.graphics.getWidth( )/background_image:getWidth(), love.graphics.getHeight()/background_image:getHeight())
    love.graphics.setFont(font2)
    love.graphics.print("Some info here", 200, 200)
    love.graphics.setFont(oldfont)
end
function ctx:draw()
    slides[ctx.slide]()
end

function ctx:mousepressed()
    ctx.slide = ctx.slide + 1
    print(ctx.slide, #slides)
    if ctx.slide > #slides then
        GS.push(scripts.gamestates.overworld)
    end
end
function ctx:leave()
    love.mouse.setGrabbed(false)
    core.entity.pop()

    print('Leaving ' .. self.name)
end

ctx.name = "TEXTSLIDES"

return ctx
