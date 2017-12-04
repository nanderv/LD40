--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--
local LOCALWIDTH = 32*20
return function(x,y, img)
    return {position={x=x ,y=y,rotation=0}, collision = { type = "explosion", box = true, polygon = { { x = -100, y = 0 }, { x = 0, y = 100 }, { x = 100, y = 0 }, {x=0, y=-100} }, dynamic = true}, toLive = 1, explosion = 1}
end