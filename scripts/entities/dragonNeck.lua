--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--
return function(fst, relativeto)
    local col_shape =  { type = "head", box = false, polygon = { { x = 0, y = 0 }, { x = -10, y = 30 }, {x=0,y=50},{ x = 10, y = 30 } }, dynamic = true }
    local position
    if fst then
         position = { x =0, y = -150, rotation =0 }
    else
        position = { x =0, y = -200, rotation =0 }
    end
    pprint(position)
    return  {collision = col_shape, position = position, dragonNeck = true, relativeto = relativeto}
end