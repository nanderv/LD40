return function(dt, txt)
    if love.joystick.getJoystickCount() > 0 then
        core.run("player", scripts.systems.controls.joystick, { dt = dt })
    end
    core.run("player", scripts.systems.controls.wasd, { dt = dt })
    core.run("mouseplayer", scripts.systems.controls.mouse, { dt = dt })
    scripts.systems.collision.collision.functions.update(dt)
    scripts.systems.camera.update(dt)
    scripts.systems.helpers.relative_position.functions.update(dt)
    scripts.systems.map.areas.update(dt)

    core.run("hoard", scripts.systems.money.money.update, { dt = dt, txt = txt })

end