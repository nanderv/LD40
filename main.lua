pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'

function love.load()
    require 'scripts'
    scripts.systems.collision.collision.functions.reset()
    core.system.add(scripts.systems.collision.collision)
    core.system.add(scripts.systems.map.map)
    core.entity.add(scripts.entities.camera(0,0))
    local ent = scripts.entities.dragon(600,600, 0)
    core.entity.add(ent)

    local h1 = core.newHandler("mouse", function(event) return event.type=="mouseclick" end, {type = "list"})

    local co =  scripts.handlers.clickOn
    local handler = core.newHandler("test", co.clickArea(100,100,400,400), co.print(co.findAllClickableObjects("clickable")))
    h1.run[1] = handler
    core.addHandler(h1)
     h1 = core.newHandler("keys", function(event) return event.type=="key" end, {type = "list"})

    handler = core.newHandler("RELOAD", function(event) return event.key=="f9" end, RELOADALL)
    core.addHandler(h1)
    h1.run[1] = handler
    core.entity.add(scripts.entities.wall(1,1))
    core.entity.add(scripts.entities.wall(5,5))
    pprint(scripts.systems.map.map.pathFind({x=0,y=0}, {x=10,y=10}))
    pprint(core.findHandler("test"))

end

function love.update(dt)
    scripts.main.mainloop(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.translate( scripts.systems.camera.toX(0), scripts.systems.camera.toY(0) )
    scripts.systems.collision.debug_draw(dt)
    core.run("wiskers", scripts.systems.draw_wiskers, {dt=dt})
    love.graphics.pop()
    love.graphics.print(love.timer.getFPS(), 10, 10)
    love.graphics.print(collectgarbage('count'), 50, 10)

end

function love.mousepressed( x, y, button )
    core.runEvent({x = x, y = y, button = button, type = "mouseclick"})
end
function love.keypressed( key, scancode, isrepeat )
    core.runEvent({key=key, scancode=scancode,isrepeat=isrepeat,type="key"})
end