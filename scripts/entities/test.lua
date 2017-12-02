--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 13:35
-- To change this template use File | Settings | File Templates.
--
SWIDTH = 32
return function(x,y, relativeto)
    return {position={x=x ,y=y,rotation=0}, collision = { type = "cookie", box = true, polygon = { { x = 0, y = 0 }, { x = SWIDTH, y = 0 }, { x = SWIDTH, y = SWIDTH*10000 }, {x=0, y=SWIDTH} }, dynamic = true }, relativeto = relativeto}
end