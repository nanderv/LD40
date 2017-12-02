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
        if E.dragonHead and E.dragonHead[1] and E.dragonHead[1].position.rotation ~= entity.position.rotation then
            -- rotateTowards
            local a_rot = entity.position.rotation -  E.dragonHead[1].position.rotation
            while  a_rot < 0 do
                a_rot =  a_rot+math.pi*2
            end
            while a_rot > math.pi*2 do
                a_rot = a_rot - math.pi*2
            end
            if math.abs(a_rot) > 0.01 then
                if a_rot > math.pi then
                    entity.position.rotation = entity.position.rotation  - dt
                else
                    entity.position.rotation = entity.position.rotation  + dt
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