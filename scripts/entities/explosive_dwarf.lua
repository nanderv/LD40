local SIZE = 32

return function(x, y, rotation)
    local col_shape = {
        type = "explosive_dwarf",
        box = false,
        polygon = { { x = SIZE / 2, y = SIZE / 2 }, { x = SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = SIZE / 2 } },
        dynamic = false,
        moving = true
    }
    local position = { x = x, y = y, rotation = rotation }
    return {
        collision = col_shape,
        position = position,
        dwarf = true,
        explosive = true,
        offset = math.random(),
        updateframe = math.random(4),
        hp = 30,
        fuse_offset = math.random(15),
        gold = 5,
        speed = 0.16,
        rotatespeed = 0.5
    }
end