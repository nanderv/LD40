--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 16:41
-- To change this template use File | Settings | File Templates.
--

local resource = love.graphics.newImage("assets/images/sprites/dragon/dragon head.png")
return function(entity)
    love.graphics.draw(resource,entity.position.x, entity.position.y, entity.position.rotation, .7, .7, resource:getWidth()/2, resource:getHeight()/2)
end