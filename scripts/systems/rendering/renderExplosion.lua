--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 16:41
-- To change this template use File | Settings | File Templates.




-- DEPRECATED
-- USING SPRITEBATCH NOW




local resource = love.graphics.newImage("assets/images/animations/explode.png")
local frames = {}

local h = resource:getHeight()
for i=1,7 do
    frames[#frames + 1] =  love.graphics.newQuad((i-1)*resource:getWidth()/12, 0, h, h, resource:getDimensions())
end
return function(entity)
    love.graphics.draw(resource, frames[math.floor(entity.explosion)],entity.position.x, entity.position.y, entity.position.rotation, 1, 1, resource:getHeight()/2, resource:getHeight()/2)
end
