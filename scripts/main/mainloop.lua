
return function(dt)
    core.run("move", scripts.systems.controls.wasd, { dt = dt })
    core.run("move", scripts.systems.controls.mouse, { dt = dt })
    scripts.systems.collision.collision.functions.update(dt)

end