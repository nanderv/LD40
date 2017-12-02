local ctx = GS.new()
local input = { text = "" }


function ctx:enter(from)
    ctx.from = from
    scripts.systems.money.money.end_raid()
--    core.entity.add(BOARD)
    GS.pop()
end

function ctx:update(dt)
    local oldfont = love.graphics.getFont()
    love.graphics.setNewFont(18)

    suit.layout:reset((love.graphics.getWidth() / 2) + 2, 300)
    suit.layout:padding(5)
    suit.layout:push(suit.layout:row(400, 50))
    suit.Input(input, suit.layout:col(275, 50))
    if suit.Button("Give to son", suit.layout:col(120, 50)).hit then
        scripts.systems.money.money.give_to_son()
    end
    suit.layout:pop()
    if suit.Button("Begin raid", suit.layout:row()).hit then
        self:leave()
    end
    if suit.Button("Next day", suit.layout:row()).hit then
        scripts.systems.money.money.next_turn()
    end

    suit._instance:registerDraw(suit._instance.theme.Button, "Chat: <Son's name here> (kid)", {id="Chatbox_Title", font=love.graphics.getFont()}, love.graphics.getWidth() / 2 - 405, 300, 400, 50)
    suit._instance:registerDraw(suit._instance.theme.Button, "", {id="Chatbox", font=love.graphics.getFont()}, love.graphics.getWidth() / 2 - 405, 355, 400, 105)
    love.graphics.setFont(oldfont)
end

function ctx:draw()
    ctx.from:draw()
    love.graphics.push()
    love.graphics.translate(scripts.systems.camera.toX(0), scripts.systems.camera.toY(0))
    scripts.systems.collision.debug_draw(dt)
    love.graphics.pop()

    core.run("hoard", scripts.systems.money.money.show_money, {})
    suit.draw()
    love.graphics.print("<Son's name here> > Daddy!\n\tCan I PLEASE have more moneys?\n\tI need them for college, and\n\tif I don't get enough, I won't pass!", love.graphics.getWidth() / 2 - 400, 360)

    love.graphics.print(love.timer.getFPS(), 10, 30)
    love.graphics.print(collectgarbage('count'), 50, 30)
end

function ctx:leave()
    scripts.systems.money.money.start_raid()
    love.mouse.setGrabbed(false)
    print('leaving')
end

return ctx