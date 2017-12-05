--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 14:56
-- To change this template use File | Settings | File Templates.
--
local s = {}

s.update = function()
    local player = core.filter.get("player")

    if player == nil then
        return
    end
    local camera = core.filter.get("camera")
    if not camera then return end
    local width = love.graphics.getWidth( )
    local height = love.graphics.getHeight( )

    local x , y = width/2, height/2
    if(camera.position.x + x - camera.camera.x > player.position.x) then
        camera.position.x = player.position.x - x + camera.camera.x
    end

    if(camera.position.x + x +  camera.camera.x < player.position.x ) then
        camera.position.x = player.position.x - x - camera.camera.x

    end

    if(camera.position.y + y - camera.camera.y > player.position.y) then
        camera.position.y = player.position.y - y + camera.camera.y
    end

    if(camera.position.y + y +  camera.camera.y < player.position.y ) then
        camera.position.y = player.position.y - y - camera.camera.y

    end

end
function s.toX(x)
    local camera = core.filter.get("camera") or {x=0,y=0 }
    return x - math.floor(camera.position.x)
end
function s.toY(y)
    local camera = core.filter.get("camera") or {x=0,y=0 }
    return y - math.floor(camera.position.y)
end
return s