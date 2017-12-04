local resource = love.graphics.newImage("assets/images/sprites/ballista/arrow.png")
return function(entity)
    love.graphics.draw(resource,entity.position.x, entity.position.y, entity.position.rotation, .3, .3, resource:getWidth()/2, resource:getHeight()/2)
end