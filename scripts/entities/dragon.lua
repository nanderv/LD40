--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 12:45
-- To change this template use File | Settings | File Templates.
--
return function(x, y, rotation)
    local col_shape =  { type = "player", box = false, polygon = { { x = 0, y = -150 }, { x = -50, y = 0 }, {x=0,y=150},{ x = 50, y = 0 } }, dynamic = true }
    local position = { x = x, y = y, rotation = rotation }
    local dragon = {collision = col_shape, position = position, player = true }

    return dragon
end


