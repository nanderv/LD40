return function(entity, args)
    local dt = args.dt
    local speed = entity.speed

    if not entity.dx and not entity.dy then
        local target = core.rotate_point({ x = 0, y = -speed, rotation = 0 }, entity.position.rotation)
        entity.dx = target.x
        entity.dy = target.y

        entity.dpf = math.sqrt(entity.dx * entity.dx + entity.dy * entity.dy)
    end

    entity.distance = entity.distance + entity.dpf * speed * dt

    if entity.distance > entity.range then
        entity.hp = 0
    end

    -- move entity towards target
    entity.position.x = entity.position.x + entity.dx * speed * dt
    entity.position.y = entity.position.y + entity.dy * speed * dt

    entity.position.x = entity.position.x
    entity.position.y = entity.position.y
end