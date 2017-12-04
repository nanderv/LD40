return function(entity, args)
    local pp = core.filter.get("player").position
    local ep = entity.position

    local dx, dy = pp.x - ep.x, pp.y - ep.y

    local distance = math.sqrt(dx * dx + dy * dy)

    if distance < entity.range then
        entity.counter = entity.counter + args.dt
        while entity.counter >= entity.spawnrate do
            entity.counter = entity.counter - entity.spawnrate
            core.entity.add(scripts.entities.arrow(entity.position.x, entity.position.y, entity.position.rotation, entity.range, entity.arrow_damage, entity.offset))
            entity.spawns = entity.spawns + 1
            print("Spawned " .. entity.spawns)
        end
    end
end
