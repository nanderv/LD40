return function(entity, args)
    local dt = args.dt
    local deadzone = 0.2
    local speed = 180

    local px, py, pr = entity.position.x, entity.position.y, entity.position.rotation

    local joystick = love.joystick.getJoysticks()[1]
    if not joystick then
        print("No joystick! That should never happen!")
        return
    end

    -- analog
    local leftx = joystick:getAxis(1)
    local lefty = joystick:getAxis(2)
    local rightx = joystick:getAxis(4)
    local righty = joystick:getAxis(5)
    local lt = joystick:getAxis(3)
    local rt = joystick:getAxis(6)

    -- buttons
    local button = {}
    button.a = joystick:isDown(1)
    button.b = joystick:isDown(2)
    button.x = joystick:isDown(3)
    button.y = joystick:isDown(4)

    -- looking
    if math.abs(leftx) > deadzone or math.abs(lefty) > deadzone then
        entity.mousecontrol = false
        if leftx > 0 then
            pr = math.atan(lefty / leftx) + math.pi / 2
        else
            pr = math.atan(lefty / leftx) - math.pi / 2
        end
    end

    -- movement
    local absrx = math.abs(rightx)
    local absry = math.abs(righty)

    if absrx > deadzone or absry > deadzone then
        entity.mousecontrol = false
        if rightx < 0 then
            px = px - speed * dt * absrx
        else
            px = px + speed * dt * absrx
        end
        if righty < 0 then
            py = py - speed * dt * absry
        else
            py = py + speed * dt * absry
        end
    end

    -- print("==========================")
    -- print("leftx", joystick:getAxis(1))
    -- print("lefty", joystick:getAxis(2))
    -- print("lt", joystick:getAxis(3))
    -- print("rightx", joystick:getAxis(4))
    -- print("righty", joystick:getAxis(5))
    -- print("rt", joystick:getAxis(6))

    -- Show all gamepad buttons (debug)
    -- print("==========================")
    for i = 1, 11 do
        -- print(i, joystick:isDown(i))
        if joystick:isDown(i) then
            entity.mousecontrol = false
        end
    end

    if button.a then
        print("Fire!")
    end

    -- vibration
    local vib = entity.vibration
    if vib then
        joystick:setVibration(vib.left, vib.right, -1)
    end

    entity.position.x, entity.position.y, entity.position.rotation = px, py, pr
    return true, false
end