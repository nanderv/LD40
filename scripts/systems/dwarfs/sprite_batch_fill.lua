return function(entity, args)
    args.sb:add(entity.position.x, entity.position.y, entity.position.rotation, 1, 1, args.image:getWidth() / 2, args.image:getHeight() / 2, 0, 0)
end