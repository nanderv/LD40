return function(entity, args)
    if entity.arrow then
        return
    end

    local x, y
    if entity.explosive then
        entity.fuse = CURRENTFRAME % entity.fuse_offset > 7
        if entity.fuse then
            x = 0
        else
            x = 50
        end
    else
        x = 100
    end
    local quad = love.graphics.newQuad(x, 0, 50, 50, 150, 50)
    args.sb:add(quad, entity.position.x, entity.position.y, entity.position.rotation, 1, 1, 25, 25, 0, 0)
end