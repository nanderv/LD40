return function(entity, args)
    local dt = args.dt

    if love.keyboard.isDown("a") then
        entity.mousecontrol = true

        entity.position.x = entity.position.x - math.cos(entity.position.rotation)* 60 * dt
        entity.position.y = entity.position.y - math.sin(entity.position.rotation)* 60 * dt
    elseif love.keyboard.isDown("d") then
        entity.mousecontrol = true
        entity.position.x = entity.position.x + math.cos(entity.position.rotation)*  60 * dt
        entity.position.y = entity.position.y + math.sin(entity.position.rotation)* 60 * dt
    end
    if love.keyboard.isDown("w") then
        local a = core.filter.get("dragonHead")
        if a and a.position.rotation ~= entity.position.rotation then
            -- rotateTowards
            local a_rot = entity.position.rotation - a.position.rotation
            while  a_rot < 0 do
                a_rot =  a_rot+math.pi*2
            end
            while a_rot > math.pi*2 do
                a_rot = a_rot - math.pi*2
            end
            if math.abs(a_rot) > 0.1 then
                if a_rot > math.pi then
                    entity.position.rotation = entity.position.rotation  + dt*1.6
                else
                    entity.position.rotation = entity.position.rotation  -dt*1.6
                end
            end
        end

        entity.mousecontrol = true
        entity.position.x = entity.position.x + math.sin(entity.position.rotation)* 180 * dt
        entity.position.y = entity.position.y - math.cos(entity.position.rotation)* 180 * dt
    elseif love.keyboard.isDown("s") then
        entity.mousecontrol = true
        entity.position.x = entity.position.x - math.sin(entity.position.rotation)* 180 * dt
        entity.position.y = entity.position.y + math.cos(entity.position.rotation)* 180 * dt
    end
    return true, false
end