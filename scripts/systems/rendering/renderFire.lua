local fire = {}

local animation = love.graphics.newImage("assets/images/animations/dragon/dragonBreathComplete.png")
local quad = love.graphics.newQuad(0, 0, 280, 294, 5040, 882)
local params
function fire.update(entity, args)
    if CURRENTFRAME % 2 ~= 0 then
        local pos = core.rotate_point({ x = 0, y = -50, rotation = 0 }, entity.position.rotation)
        params = { animation, quad, entity.position.x + pos.x, entity.position.y + pos.y, entity.position.rotation, .7, .8, 140, 294 }
        return
    end
    local ef = entity.flame
    local fire = love.mouse.isDown(1)
    local fade = 13
    local loop = 6

--    print("astart: " .. ef.astart .. "  loop: " .. ef.loop .. " aend: " .. ef.aend)

    local x, y

    if fire then
        if ef.astart < fade-1 then
            -- fading in
            ef.astart = ef.astart + 1
            y = 0
            x = ef.astart
        else
            -- looping
            ef.loop = ef.loop - 1
            if ef.loop <= -1 then
                ef.loop = loop - 1
            end
            y = 1
            x = ef.loop
        end
    else
        if ef.loop >= 0 then
            ef.loop = -1
            ef.aend = 0
        end
        if ef.aend <= fade then
            -- fade out
            ef.aend = ef.aend + 1
            y = 2
            x = ef.aend
        else
            ef.astart = 0
            -- hide
            x = 2
            y = 14
        end
    end

--    if y == 0 then
--        print("FLAME START")
--    elseif y == 1 then
--        print("FLAME LOOP")
--    elseif y == 2 then
--        print("FLAME END")
--    end

    quad:setViewport(x * 280, y * 294, 280, 294)
    entity.fire = ef
    local pos = core.rotate_point({ x = 0, y = -50, rotation = 0 }, entity.position.rotation)
    params = { animation, quad, entity.position.x + pos.x, entity.position.y + pos.y, entity.position.rotation, .7, .8, 140, 294 }
end

function fire.draw()
    if params then
        love.graphics.draw(unpack(params))
    end
end

return fire