return function(entity, args)
    local dt = args.dt

    local mx, my = love.mouse.getX(), love.mouse.getY()
    local px, py = entity.position.x, entity.position.y

    local dx, dy = mx - px, my - py
    entity.position.rotation = math.atan(dy / dx)

    if love.mouse.isDown(1) then
        -- FIRE
        print("FIRE!!!")
    end
    return true, false
end