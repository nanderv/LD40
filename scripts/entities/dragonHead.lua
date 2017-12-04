--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--
return function(relativeto)
    local col_shape = { type = "head", box = false, polygon = { {x=15,y=10},{ x = -15, y = 10 }, { x = -5, y = -15 }, { x = 0, y = -20 }, { x = 5, y = -15 } }, dynamic = true }
    local position = { x = 0, y = -15, rotation = 0 }
    --    pprint(position)
    return { collision = col_shape, position = position, dragonHead = true, relativeto = relativeto, flame = { astart = 14, loop = -1, aend = 14 } }
end