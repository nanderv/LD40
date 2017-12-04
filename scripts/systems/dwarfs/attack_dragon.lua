return function(entity, args)
    -- if entity.updateframe ~= CURRENTFRAME % 5 then
    --     return
    -- end

    local dt = args.dt
    local speed = entity.speed or 0.16
    local rotatespeed = entity.rotatespeed or 0.5

    local pp, ep = core.filter.get("player").position, entity.position

    -- rotate player poligon
    local pol = scripts.systems.collision.lib.rotate_poly(core.filter.get("player"))

    -- get the line that goes down through the middle
    local x1, y1 = pol[1].x, pol[1].y
    local x2, y2 = pol[3].x, pol[3].y

    -- get the delta from entity to player
    local px, py = (pp.x + x1 + ((x2 - x1) * entity.offset)), (pp.y + y1 + ((y2 - y1) * entity.offset))
    local dx, dy = px - ep.x, py - ep.y

    -- move entity towards player
    ep.x = ep.x + dx * speed * dt
    ep.y = ep.y + dy * speed * dt

    local dr = core.get_rotation({ x = px, y = py, rotation = pp.rotation }, ep) - entity.position.rotation


    entity.position.rotation = entity.position.rotation + dr * rotatespeed * dt

    entity.position.x = ep.x
    entity.position.y = ep.y
end