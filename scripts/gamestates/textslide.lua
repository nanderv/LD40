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
    font2 = love.graphics.newFont(30)
end

function ctx:update(dt)

end
local slides  = {}
slides[1] = function()
    local oldfont = love.graphics.getFont()
    love.graphics.draw(background_image,0,0,0,love.graphics.getWidth( )/background_image:getWidth(), love.graphics.getHeight()/background_image:getHeight())
    love.graphics.setFont(font)
    love.graphics.print("Making Ends Meet", 200, 200)
    love.graphics.setFont(oldfont)
end
local function getLineSlide(line)
    return function()
        local oldfont = love.graphics.getFont()
        love.graphics.draw(background_image,0,0,0,love.graphics.getWidth( )/background_image:getWidth(), love.graphics.getHeight()/background_image:getHeight())
        love.graphics.setFont(font2)
        love.graphics.print(line, 200, 200)
        love.graphics.setFont(oldfont)
        end
end
local function getImageSlide(image)
    local l_img = love.graphics.newImage(image)
    return function()
        love.graphics.draw(l_img,0,0,0,love.graphics.getWidth( )/background_image:getWidth(), love.graphics.getHeight()/background_image:getHeight())
    end
end
slides[#slides+1] = getImageSlide("assets/images/backgrounds/dialogue window plus background1.png")
slides[#slides+1] = getImageSlide("assets/images/backgrounds/dialogue window plus background2.png")
slides[#slides+1] = getImageSlide("assets/images/backgrounds/dialogue window plus background3.png")
--slides[#slides+1] = getLineSlide("Son: Dad! Dad! I got accepted to college!")
--slides[#slides+1] = getLineSlide("Father: That’s wonderful, son! ")
--slides[#slides+1] = getLineSlide("Son: I kinda need money for books though, can you give me some from your hoard...?")
--slides[#slides+1] = getLineSlide("Father: ...")
--slides[#slides+1] = getLineSlide("Son: Come on, it’s not gonna be that much, I promise!")
--slides[#slides+1] = getLineSlide("Father: Ok...")
--slides[#slides+1] = getLineSlide("Father: I need to get more gold.\n\n Those pesky dwarves must have stolen some.\n\n They will burn.")
--
--slides[#slides+1] = getLineSlide("Every day, your child needs money for college.\nTo get money, you need to raid.\n\nWhile you're off raiding, the dwarves will steal your gold.")
--slides[#slides+1] = getLineSlide("Use WASD to move and your mouse to burn those dwarfs!")

function ctx:draw()
    slides[ctx.slide]()
end

function ctx:mousepressed()
    ctx.slide = ctx.slide + 1
    print(ctx.slide, #slides)
    if ctx.slide > #slides then
        GS.push(scripts.gamestates.game)
    end
end
function ctx:leave()
    love.mouse.setGrabbed(false)
    core.entity.pop()

    print('Leaving ' .. self.name)
end

ctx.name = "TEXTSLIDES"

return ctx
