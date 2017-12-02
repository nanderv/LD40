--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 19:01
-- To change this template use File | Settings | File Templates.
--

--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 18:57
-- To change this template use File | Settings | File Templates.
--

local ctx = GS.new()
local input = { text = "" }
function ctx:enter(from)
    ctx.from = from
    GS.pop()
end

function ctx:update(dt)
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
end

function ctx:draw()
    ctx.from:draw()
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