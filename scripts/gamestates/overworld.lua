local ctx = GS.new()
local input = { text = "" }


function ctx:enter(from)
    print("Entered " .. self.name)

    ctx.from = from
    scripts.systems.money.money.end_raid(true)
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
        print("Switching to game")
        GS.switch(scripts.gamestates.game)
    end
    if suit.Button("Next day", suit.layout:row()).hit then
        scripts.systems.money.money.next_turn()
    end
    suit.layout:reset((love.graphics.getWidth() / 4) * 2, 33)
    suit.Slider({ value = 1000, min = 0, max = 1020 }, { id = 'Health', valign = "top", notMouseEditable = true }, suit.layout:col(love.graphics.getWidth() / 4, 15))
    suit.Slider({ value = core.filter.get("hoard").current_turn_len, min = 0, max = 120 }, { id = 'Day progress', valign = "top", notMouseEditable = true }, suit.layout:col())
    suit._instance:registerDraw(suit._instance.theme.Button, "Chat: <Son's name here> (kid)", { id = "Chatbox_Title", font = love.graphics.getFont() }, love.graphics.getWidth() / 2 - 405, 300, 400, 50)
    suit._instance:registerDraw(suit._instance.theme.Button, "", { id = "Chatbox", font = love.graphics.getFont() }, love.graphics.getWidth() / 2 - 405, 355, 400, 105)
    suit._instance:registerDraw(suit._instance.theme.Button, "", { id = "Hotbar", font = love.graphics.getFont(), valign = "bottom" }, -10, -10, love.graphics.getWidth() + 10, 55)

    scripts.systems.money.money.update_text(input.text)
    love.graphics.setFont(oldfont)
end

local background_image = love.graphics.newImage("assets/images/backgrounds/overworld.png")
function ctx:draw()
    love.graphics.draw(background_image, 0, 40, 0, love.graphics.getWidth() / 1366, (love.graphics.getHeight() - 40) / 725, 0, 0)
    suit.draw()
    core.run("hoard", scripts.systems.money.money.show_money, {})
    love.graphics.print("<Son's name here> > Daddy!\n\tCan I PLEASE have more moneys?\n\tI need them for college, and\n\tif I don't get enough, I won't pass!", love.graphics.getWidth() / 2 - 400, 360)

    if DEBUG then
        love.graphics.print(love.timer.getFPS(), 10, 30)
        love.graphics.print(collectgarbage('count') / 1024, 50, 30)
    end
end

function ctx:leave()
    scripts.systems.money.money.start_raid()
    love.mouse.setGrabbed(false)

    print('Leaving ' .. self.name)
end

ctx.name = "OVERWORLD"

return ctx