return function(entity, args)
    local dt = args.dt
    local mx, my = love.mouse.getX(), love.mouse.getY()
    local px, py = scripts.systems.camera.toX(entity.position.x), scripts.systems.camera.toY(entity.position.y)

    local dx, dy = mx - px, my - py

    if mx > px then
        entity.position.rotation = math.atan(dy / dx) + math.pi/2
    else
        entity.position.rotation = math.atan(dy / dx) - math.pi/2
    end

    if love.mouse.isDown(1) then
        -- FIRE
        print("FIRE!!!")
    end
    return true, false
end