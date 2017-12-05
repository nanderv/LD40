return function(ent, args)
    if ent.position.x < 0 then
        DOSWITCH = true
        scripts.systems.money.money.end_raid(true)
        local ent = scripts.systems.money.money.get_money_ent()
        ent.money.total, ent.money.pocket_treasure = ent.money.total + ent.money.pocket_treasure, 0

    end
end