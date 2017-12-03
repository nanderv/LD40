return function(entity, args)
    entity.counter = entity.counter + args.dt
    while entity.counter >= entity.spawnrate do
        entity.counter = entity.counter - entity.spawnrate
        core.entity.add(scripts.entities[entity.spawn_type](entity.position.x, entity.position.y, entity.position.rotation))
        entity.spawns = entity.spawns + 1
--        print("Spawned " .. entity.spawns)
    end
end