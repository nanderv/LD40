return function(dt)
    if love.joystick.getJoystickCount() > 0 then
        core.run("player", scripts.systems.controls.joystick, { dt = dt })
    end
    core.run("player", scripts.systems.controls.wasd, { dt = dt })
    core.run("player", scripts.systems.leave_dungeon, {})
    core.run("mouseplayer", scripts.systems.controls.mouse, { dt = dt })
    core.run("dwarf", scripts.systems.dwarfs.attack_dragon, { dt = dt })
    core.run("ballista", scripts.systems.dwarfs.attack_dragon, { dt = dt })
    core.run("arrow", scripts.systems.ballista.arrow, { dt = dt })
    core.run("ballista", scripts.systems.ballista.ballista, { dt = dt })
    core.run("dwarfSpawner", scripts.systems.dwarfs.dwarf_spawner, { dt = dt })
    core.run("dragonHead", scripts.systems.rendering.renderFire.update, { dt = dt })
    scripts.systems.collision.collision.functions.update(dt)
    scripts.systems.camera.update(dt)
    scripts.systems.helpers.relative_position.functions.update(dt)
    scripts.systems.map.areas.update(dt)
    core.run("explosion", scripts.systems.rendering.explosionAnimation, { dt = dt })

    core.run("hp", scripts.systems.dwarfs.hp, { dt = dt })
    core.run("toLive", scripts.systems.limitedLife, { dt = dt })
end