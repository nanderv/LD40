SIZE = 32

return function(x, y, rotation)
    local col_shape = { type = "dwarf", box = false, polygon = { { x = SIZE / 2, y = SIZE / 2 }, { x = SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = -SIZE / 2 }, { x = -SIZE / 2, y = SIZE / 2 } },
        dynamic = false }
    local position = { x = x, y = y, rotation = rotation }
    local dwarf = { collision = col_shape, position = position, dwarf = true, offset = math.random(), updateframe = math.random(19) }

    return dwarf
end