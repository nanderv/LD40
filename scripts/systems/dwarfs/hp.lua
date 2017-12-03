--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 03/12/2017
-- Time: 12:07
-- To change this template use File | Settings | File Templates.
--
return function(entity)
    if entity.hp <= 0 then
        if entity.player then
            DOSWITCH = true
        else
            if entity.gold then
                local m = core.filter.get("hoard").money
                m.pocket_treasure = m.pocket_treasure + entity.gold
            end
            core.entity.remove(entity)
        end
    end
end

