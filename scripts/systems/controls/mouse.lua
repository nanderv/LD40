local fire = false
return function(entity, args)
    local dt = args.dt
    local mx, my = love.mouse.getX(), love.mouse.getY()
    local p = core.filter.get("player").position

    local cam = core.filter.get("camera")
    entity.position.rotation = core.get_rotation({ x = cam.position.x + mx, y = cam.position.y + my }, p)
    local old_rot = entity.position.rotation
    local dR = entity.position.rotation - p.rotation + math.pi
    while dR < 0 do
        dR = dR + math.pi * 2
    end
    while dR > math.pi * 2 do
        dR = dR - math.pi * 2
    end

    for v, _ in pairs(F.dragonNeck) do
        v.position.rotation = p.rotation + (dR - math.pi) / 3 * v.segment
    end

    if love.mouse.isDown(1) then
        if not fire then
            core.entity.add(scripts.entities.fire(core.filter.get("dragonHead")))
        end
        fire = true
    else
        if fire then
            for k, v in pairs(F.breath) do
                core.entity.remove(v)
            end
        end
        fire = false
    end
    return true, false
end