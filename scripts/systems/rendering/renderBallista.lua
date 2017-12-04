local resource = love.graphics.newImage("assets/images/sprites/ballista/ballista.png")
return function(entity)
    love.graphics.draw(resource, entity.position.x, entity.position.y, entity.position.rotation - math.pi, .5, .5, resource:getWidth() / 2, resource:getHeight() / 2)
end