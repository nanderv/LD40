--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2017
-- Time: 16:41
-- To change this template use File | Settings | File Templates.




-- DEPRECATED
-- USING SPRITEBATCH NOW





return function(entity, args)
    entity.explosion =(entity.explosion + args.dt*7-1)%7 + 1

end
