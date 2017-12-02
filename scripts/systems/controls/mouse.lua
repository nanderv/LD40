return function(entity, args)
    local dt = args.dt
    local mx, my = love.mouse.getX(), love.mouse.getY()
    local px, py = scripts.systems.camera.toX(entity.position.x), scripts.systems.camera.toY(entity.position.y)

    local dx, dy = mx - px, my - py
    local old_rot = entity.position.rotation
    local positive = true
    if mx > px then
        positive = false
        entity.position.rotation = math.atan(dy / dx) - math.pi / 2
    else

        entity.position.rotation = math.atan(dy / dx) + math.pi / 2
    end
    local p = E.player[1].position
    local dR = entity.position.rotation - p.rotation + math.pi
    while dR < 0 do
        dR = dR + math.pi * 2
    end
    while dR > math.pi * 2 do
        dR = dR - math.pi * 2
    end

    for k, v in ipairs(E.dragonNeck) do

        v.position.rotation = p.rotation + dR / 2
    end

    if love.mouse.isDown(1) then
        -- FIRE
    end
    return true, false
end