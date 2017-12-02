return function(entity, args)
    if entity.updateframe ~= E.currentframe % 20 then
        return
    end

    local dt = args.dt
    local speed = 0.5

    local pp, ep = E.player[1].position, entity.position

    local hit, x1, y1, x2, y2 = scripts.systems.collision.lib.line_in_polygon(scripts.systems.collision.lib.rotate_poly(E.player[1]), ep, pp, pp, { x = 0, y = 0 })

    if not hit then
        return
    end

--     DEBUGVALUE = DEBUGVALUE or {}
--     DEBUGVALUE[entity.offset] = { pp.x + x1 + ((x2 - x1) * entity.offset), pp.y + y1 + ((y2 - y1) * entity.offset), ep.x, ep.y }

    local dx, dy = (pp.x + x1 + ((x2 - x1) * entity.offset)) - ep.x, (pp.y + y1 + ((y2 - y1) * entity.offset)) - ep.y

    ep.x = ep.x + dx * speed * dt
    ep.y = ep.y + dy * speed * dt


    entity.position.x = ep.x
    entity.position.y = ep.y
end