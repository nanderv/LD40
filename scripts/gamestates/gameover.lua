local ctx = GS.new()

local font

function ctx:enter()
    print("Entered " .. self.name)
    core.entity.push()
    font = love.graphics.newFont(56)
end

function ctx:update(dt)


end


function ctx:draw()
    local oldfont = love.graphics.getFont()
    love.graphics.setFont(font)
    love.graphics.print("GAME OVER", 200, 200)
    love.graphics.setFont(oldfont)
    if DEBUG then
        love.graphics.print(love.timer.getFPS(), 10, 30)
        love.graphics.print(collectgarbage('count') / 1024, 50, 30)
    end
end


function ctx:leave()
    love.mouse.setGrabbed(false)
    core.entity.pop()

    print('Leaving ' .. self.name)
end

ctx.name = "GAMEOVER"

return ctx
