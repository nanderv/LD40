local function register()
    local co = scripts.handlers.clickOn
    local clickAreaHandler = core.newHandler("test", co.clickArea(100, 100, 400, 400), co.print(co.findAllClickableObjects("clickable")))
    local nextDayButtonHandler = core.newHandler("nd", co.clickArea(500, 0, 550, 220), scripts.systems.money.money.debug_button_press(co.findAllClickableObjects("clickable")))
    local reloadHandler = core.newHandler("RELOAD", function(event) return event.key == "f9" end, RELOADALL)

    local mouseClickHandler = core.newHandler("mouse", function(event) return event.type == "mouseclick" end, { type = "list" })
    mouseClickHandler.run[1] = clickAreaHandler
    mouseClickHandler.run[2] = nextDayButtonHandler
    core.addHandler(mouseClickHandler)

    local keyHandler = core.newHandler("keys", function(event) return event.type == "key" end, { type = "list" })
    keyHandler.run[1] = reloadHandler
    core.addHandler(keyHandler)
end

return {register=register}