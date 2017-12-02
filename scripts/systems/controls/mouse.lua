return function(entity, args)
    local dt = args.dt
    local mx, my = love.mouse.getX(), love.mouse.getY()

    entity.position.rotation = core.get_rotation(entity.position,{ x = E.camera[1].position.x + mx, y = E.camera[1].position.y + my })

    if love.mouse.isDown(1) then
        -- FIRE
    end
    return true, false
end