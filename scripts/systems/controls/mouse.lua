local fire = false
return function(entity, args)
    local dt = args.dt
    local mx, my = love.mouse.getX(), love.mouse.getY()

    entity.position.rotation = core.get_rotation({ x = E.camera[1].position.x + mx, y = E.camera[1].position.y + my }, E.player[1].position)
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
        v.position.rotation = p.rotation + (dR -math.pi) /3 * v.segment
    end

    if love.mouse.isDown(1)  then
        if not fire then
            core.entity.add(scripts.entities.fire(E.dragonHead[1]))
        end
        fire = true
    else
        if fire then
            for k,v in pairs(E.breath) do
                core.entity.remove(v)
            end
        end
        fire = false
    end
    return true, false
end