local daylen = 1 -- seconds

local money = {}

-- Multiplier used for the scale of the money
money.multiplier = 100

local txt = ""

money.get_money_ent = function()
    local l = E["hoard"]
    local entity
    for _, v in ipairs(l) do
        return v
    end
end

money.update = function(entity, args)
    local ent = entity
    ent.current_turn_len = ent.current_turn_len + args.dt
    ent.current_second_progress = ent.current_second_progress + args.dt
    txt = args.txt

    --    if ent.current_turn_len >= daylen then
    --        ent.current_turn_len = 0
    --
    --        local gameover = not money.next_turn()
    --    end
    if ent.current_second_progress >= daylen then
        ent.current_second_progress = 0
        money.second()
    end
end

money.give_to_son = function(amount)
    if not amount then return end

    local ent = money.get_money_ent()
    print(amount .. ":" .. ent.money.total)
    if amount < ent.money.lastgiven * 1.05 or amount > ent.money.total then
        -- Too little money!
        return false
    end
    ent.son.happy_this_turn = true
    ent.money.lastgiven = amount
    ent.money.totalgiven = ent.money.totalgiven + ent.money.lastgiven
    ent.money.total = ent.money.total - amount
    ent.money.lastleft = ent.money.total

    return true
end

money.second = function()
    local ent = money.get_money_ent()

    if ent.in_raid then
        local red = math.floor((ent.money.lastleft * 0.03) + (ent.money.totalgiven * 0.05))
        ent.money.total = ent.money.total - red
        if ent.money.total < 0 then ent.money.total = 0 end
        return red
    end
end

money.open_chest = function()
    local ent = money.get_money_ent()

    ent.money.pocket_treasure = ent.money.pocket_treasure + ((ent.raid_level * money.multiplier) * (1 + math.random()))
end

money.start_raid = function()
    local ent = money.get_money_ent()

    ent.in_raid = true
end

money.end_raid = function(dead)
    local ent = money.get_money_ent()

    ent.money.total, ent.money.pocket_treasure = ent.money.pocket_treasure, 0
    ent.in_raid = false
    ent.raid_leve = ent.raid_level + 1
end

money.get_last_left = function()
    return money.get_money_ent().money.lastleft
end

money.next_turn = function()
    local ent = money.get_money_ent()

    if not ent.son.happy_this_turn then
        return false
    end

    ent.son.happy_this_turn = false
    return true
end

money.debug_button = function(type)
    local ent = money.get_money_ent()
    pprint(ent.money)

    if type == 0 then
        if money.give_to_son(tonumber(txt)) then
            print("Gave " .. txt .. " coins to son")
        else
            print("Failed to give " .. txt .. " coins to son")
        end
    elseif type == 1 then
        money.open_chest()
        print("Got money from chest!")
    elseif type == 2 then
        money.next_turn()
        print("Advanced the day")
    elseif type == 3 then
        if ent.in_raid then
            money.end_raid()
            print("Ended raid")
        else
            money.start_raid()
            print("Started raid")
        end
    end

    pprint(ent.money)
end

money.show_money = function(ent)
    love.graphics.print("Total in stash: " .. ent.money.total, 10, 30)
    love.graphics.print("Last given: " .. ent.money.lastgiven, 10, 50)
    love.graphics.print("Total given: " .. ent.money.totalgiven, 10, 70)
    love.graphics.print("Last left over: " .. ent.money.lastleft, 10, 90)
    love.graphics.print("Treasure in pcket: " .. ent.money.pocket_treasure, 10, 110)
    if ent.in_raid then
        love.graphics.print("Raid: Yes", 10, 130)
    else
        love.graphics.print("Raid: No", 10, 130)
    end
end

return money