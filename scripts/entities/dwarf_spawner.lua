local SIZE = 32
return function(x, y, rotation, type, dps, health, gold)
    local col_shape = {
        type = "spawner",
        box = true,
        polygon = { { x = SIZE / 2, y = SIZE / 2 }, { x = SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = SIZE / 2 } },
        dynamic = false
    }
    local position = { x = x, y = y, rotation = rotation }
    local dwarf_spawner = {
        collision = col_shape,
        position = position,
        spawnrate = dps,
        dwarfSpawner = true,
        spawn_type = type,
        counter = 0,
        spawns = 0,
        hp = health,
        gold = gold
    }
    return dwarf_spawner
end
