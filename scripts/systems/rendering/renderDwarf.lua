--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 16:41
-- To change this template use File | Settings | File Templates.




-- DEPRECATED
-- USING SPRITEBATCH NOW




local resource = love.graphics.newImage("assets/images/sprites/dwarf/dwarf0.png")
return function(entity)
love.graphics.draw(resource,entity.position.x, entity.position.y, entity.position.rotation, 1, 1, resource:getWidth()/2, resource:getHeight()/2)
end
