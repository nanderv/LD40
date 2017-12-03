--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 16:41
-- To change this template use File | Settings | File Templates.




-- DEPRECATED
-- USING SPRITEBATCH NOW




local resources = {}
return function(entity)
    if(not resources[entity.mapImage]) then
        resources[entity.mapImage] = love.graphics.newImage("assets/maps/"..entity.mapImage..".png")
    end
    love.graphics.draw(resources[entity.mapImage],entity.position.x, entity.position.y)
end