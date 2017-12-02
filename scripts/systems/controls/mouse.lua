return function(entity, args)
    local dt = args.dt
    local mx, my = love.mouse.getX(), love.mouse.getY()

    entity.position.rotation = core.get_rotation(entity.position,{ x = E.camera[1].position.x + mx, y = E.camera[1].position.y + my })
    local old_rot = entity.position.rotation
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