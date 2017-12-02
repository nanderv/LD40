--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--
SWIDTH = 32
return function(x,y)
    return {position={x=x*SWIDTH ,y=y*SWIDTH,rotation=0}, mapPosition={x=x,y=y}, collision = { type = "test", box = true, polygon = { { x = 0, y = 0 }, { x = SWIDTH, y = 0 }, { x = SWIDTH, y = SWIDTH }, {x=0, y=SWIDTH} }, dynamic = false }}
end