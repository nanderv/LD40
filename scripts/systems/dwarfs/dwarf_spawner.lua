return function(entity, args)
    print("HERE")
    if entity.spawn_every_x_frames then
        entity.counter = entity.counter + 1
        if entity.counter >= entity.spawn_every_x_frames then
            entity.counter = 0
            core.entity.add(scripts.entities.dwarf(unpack(entity.position)))
        end
    end
    if entity.spawn_x_dwarfs_per_frame then
        for i = 1, entity.spawn_x_dwarfs_per_frame do
            core.entity.add(scripts.entities.dwarf(unpack(entity.position)))
        end
    end
end