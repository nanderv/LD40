--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 12:45
-- To change this template use File | Settings | File Templates.
--
return function(relativeto)
    local col_shape =  { type = "fire", box = false, polygon = {  { x = 5, y = 0 },{ x = -5, y = 0 }, { x = -60, y = -200 }, {x=60,y=-200} }, dynamic = true }
    local position = core.rotate_point({ x = 0, y = -20, rotation = 0 }, relativeto.position.rotation)
    position.rotation = 0
    local dragon = {collision = col_shape, position = position, breathfire = true, relativeto= relativeto }

    return dragon
end


