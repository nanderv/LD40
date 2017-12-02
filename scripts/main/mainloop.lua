
return function(dt)
    core.run("player", scripts.systems.controls.wasd, { dt = dt })
    core.run("player", scripts.systems.controls.mouse, { dt = dt })
    scripts.systems.collision.collision.functions.update(dt)
end