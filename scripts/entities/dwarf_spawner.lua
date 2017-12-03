local SIZE = 32
return function(x, y, rotation, spawn_every_x_frames, spawn_x_dwarfs_per_frame)
    local col_shape = {
        type = "wall",
        box = true,
        polygon = { { x = SIZE / 2, y = SIZE / 2 }, { x = SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = SIZE / 2 } },
        dynamic = false
    }
    local position = { x = x, y = y, rotation = rotation }
    local dwarf_spawner = {
        collision = col_shape,
        position = position,
        spawn_every_x_frames = spawn_every_x_frames,
        spawn_x_dwarfs_per_frame = spawn_x_dwarfs_per_frame,
        dwarf_spawner = true
    }
    return dwarf_spawner
end
