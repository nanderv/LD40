--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--
local LOCALWIDTH = 32*20
return function(x,y, img)
    return {position={x=x*LOCALWIDTH ,y=y*LOCALWIDTH,rotation=0}, mapPosition={x=x,y=y}, collision = { type = "wall", box = true, polygon = { { x = 0, y = 0 }, { x = LOCALWIDTH, y = 0 }, { x = LOCALWIDTH, y = LOCALWIDTH }, {x=0, y=LOCALWIDTH} }, dynamic = false}, mapImage = img}
end