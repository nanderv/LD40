return function(entity, args)
    local dt = args.dt

    if love.keyboard.isDown("a") then
        entity.position.x = entity.position.x - math.cos(entity.position.rotation)* 60 * dt
        entity.position.y = entity.position.y - math.sin(entity.position.rotation)* 60 * dt
    elseif love.keyboard.isDown("d") then
        entity.position.x = entity.position.x + math.cos(entity.position.rotation)*  60 * dt
        entity.position.y = entity.position.y + math.sin(entity.position.rotation)* 60 * dt
    end
    if love.keyboard.isDown("w") then
        entity.position.x = entity.position.x + math.sin(entity.position.rotation)* 180 * dt
        entity.position.y = entity.position.y - math.cos(entity.position.rotation)* 180 * dt
    elseif love.keyboard.isDown("s") then
        entity.position.x = entity.position.x - math.sin(entity.position.rotation)* 180 * dt
        entity.position.y = entity.position.y + math.cos(entity.position.rotation)* 180 * dt
    end
    return true, false
end