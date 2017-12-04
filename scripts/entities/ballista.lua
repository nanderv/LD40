local SIZE = 64
return function(x, y, rotation, spawnrate, health, gold, range, arrow_damage)
    local col_shape = {
        -- Behaviours should be the same as a spawner
        type = "spawner",
        box = true,
        polygon = { { x = SIZE / 2, y = SIZE / 2 }, { x = SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = SIZE / 2 } },
        dynamic = false
    }
    local position = { x = x, y = y, rotation = rotation }
    local dwarf_spawner = {
        collision = col_shape,
        position = position,
        speed = 0,
        rotatespeed = 0.5,
        spawnrate = spawnrate,
        ballista = true,
        counter = 0,
        offset = math.random(),
        spawns = 0,
        hp = health,
        gold = gold,
        range = range,
        arrow_damage = arrow_damage
    }
    return dwarf_spawner
end
