return function(ent, args)
    if ent.position.x < 0 then
        DOSWITCH = true
        scripts.systems.money.money.end_raid(true)
    end
end