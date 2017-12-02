return function(entity, args)
    -- if entity.updateframe ~= E.currentframe % 5 then
    --     return
    -- end

    local dt = args.dt
    local speed = 0.02
    local rotationspeed = 0.02

    local pp, ep = E.player[1].position, entity.position

    local pol = scripts.systems.collision.lib.rotate_poly(E.player[1])
    --    pprint(scripts.systems.collision.lib.rotate_poly(E.player[1]))

    local x1, y1 = pol[1].x, pol[1].y
    local x2, y2 = pol[3].x, pol[3].y


    --    local hit, x1, y1, x2, y2 = scripts.systems.collision.lib.line_in_polygon(scripts.systems.collision.lib.rotate_poly(E.player[1]), ep, pp, pp, { x = 0, y = 0 })

    --    if not hit then
    --        return
    --    end
    if DEBUG then
        DEBUGVALUE = DEBUGVALUE or {}
        DEBUGVALUE[entity.offset] = { pp.x + x1 + ((x2 - x1) * entity.offset), pp.y + y1 + ((y2 - y1) * entity.offset), ep.x, ep.y }
        local mx, my = love.mouse.getX(), love.mouse.getY()
        DEBUGVALUE[1] = { E.camera[1].position.x + mx, E.camera[1].position.y + my, entity.position.x, entity.position.y }
    end

    local dx, dy = (pp.x + x1 + ((x2 - x1) * entity.offset)) - ep.x, (pp.y + y1 + ((y2 - y1) * entity.offset)) - ep.y

    ep.x = ep.x + dx * speed * dt
    ep.y = ep.y + dy * speed * dt

    --    print(dy, dx, dy / dx, math.atan(dy / dx))

    if ep.x >= pp.x then
        entity.position.rotation = math.atan(dy / dx) - math.pi / 2
    else
        entity.position.rotation = math.atan(dy / dx) + math.pi / 2
    end

    if math.abs(dy / dx) > math.pi then
        if ep.y > pp.y then
            entity.position.rotation = 0
        else
            entity.position.rotation = math.pi
        end
    end

    entity.position.x = ep.x
    entity.position.y = ep.y
end