local height = 32
local width = 8
return function(x, y, rotation, range, damage, offset)
    local col_shape = {
        -- Behaviours should be the same as a spawner
        type = "arrow",
        box = true,
        polygon = { { x = width / 2, y = height / 2 }, { x = width / 2, y = -height / 2 }, { x = -width / 2, y = -height / 2 }, { x = -width / 2, y = height / 2 } },
        dynamic = false,
        moving = true
    }
    local position = { x = x, y = y, rotation = rotation }
    local dwarf_spawner = {
        collision = col_shape,
        position = position,
        arrow = true,
        speed = 25,
        distance = 0,
        hp = 5,
        offset = offset,
        range = range,
        damage = damage,
        dpf = 0
    }
    return dwarf_spawner
end
