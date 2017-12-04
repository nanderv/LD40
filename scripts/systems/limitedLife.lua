--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 04/12/2017
-- Time: 14:34
-- To change this template use File | Settings | File Templates.
--


return function(entity, arg)
    entity.toLive = entity.toLive - arg.dt

    if entity.toLive <= 0 then
        core.entity.remove(entity)
    end
end