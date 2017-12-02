
return function(dt)
    core.run("player", scripts.systems.controls.wasd, { dt = dt })
    scripts.systems.collision.collision.functions.update(dt)
end