
return function(dt, txt)
    core.run("move", scripts.systems.controls.wasd, { dt = dt })
    scripts.systems.collision.collision.functions.update(dt)

    core.run("hoard", scripts.systems.money.money.update, { dt = dt, txt = txt })
end