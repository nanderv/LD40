--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 16:41
-- To change this template use File | Settings | File Templates.
--

local resources = {love.graphics.newImage("assets/images/sprites/dragon/dragon neck 0.png"),love.graphics.newImage("assets/images/sprites/dragon/dragon neck 1.png"), love.graphics.newImage("assets/images/sprites/dragon/dragon neck 2.png")}
return function(entity)
    local resource = resources[entity.segment]
    love.graphics.draw(resource,entity.position.x, entity.position.y, entity.position.rotation, .7, .7, resource:getWidth()/2, resource:getHeight())
end