local daylen = 120 -- seconds

local money = {}

-- Multiplier used for the scale of the money
money.multiplier = 100

local txt = ""

money.get_money_ent = function()
    return core.filter.get("hoard")
end

money.update_text = function(text)
    txt = text
end

money.update = function(entity, args)
    local ent = entity
    ent.current_turn_len = ent.current_turn_len + args.dt
    ent.current_second_progress = ent.current_second_progress + args.dt

    if ent.current_turn_len >= daylen then
        HOARD.current_turn_len = 0
        ent.current_turn_len = 0
        scripts.systems.money.money.end_raid(false)
        DOSWITCH = true
    end

    if ent.current_second_progress >= 1 then
        ent.current_second_progress = 0
        money.second()
    end
end

money.give_to_son = function(amount)
    amount = amount or tonumber(txt)
    if not amount then return end

    local ent = money.get_money_ent()
    if not ent then return end

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
    if not ent then return end

    if ent.in_raid then
        local red = math.floor((ent.money.lastleft * 0.03) + (ent.money.totalgiven * 0.05))
        ent.money.total = ent.money.total - red
        if ent.money.total < 0 then ent.money.total = 0 end
        return red
    end
end

money.open_chest = function()
    local ent = money.get_money_ent()
    if not ent then return end

    ent.money.pocket_treasure = ent.money.pocket_treasure + ((ent.raid_level * money.multiplier) * (1 + math.random()))
end

money.start_raid = function()
    local ent = money.get_money_ent()
    if not ent then return end

    ent.in_raid = true
end

money.end_raid = function(alive)
    local ent = money.get_money_ent()
    if not ent then return end
    if not ent.in_raid then return end

    if alive then
        ent.money.total, ent.money.pocket_treasure = ent.money.total + ent.money.pocket_treasure, 0
    else
        ent.money.pocket_treasure = 0
    end

    ent.in_raid = false
    ent.raid_leve = ent.raid_level + 1
end

money.get_last_left = function()
    local ent = money.get_money_ent()
    if not ent then return end
    return ent.money.lastleft
end

money.next_turn = function()
    local ent = money.get_money_ent()
    if not ent then return end

    if not ent.son.happy_this_turn then
        return false
    end

    ent.son.happy_this_turn = false
    return true
end

money.debug_button = function(type)
    local ent = money.get_money_ent()
    if not ent then return end
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
    local quanta = (love.graphics.getWidth() - 20) / 4
    local oldfont = love.graphics.getFont()
    love.graphics.setNewFont(20)
    love.graphics.printf("Total in stash: " .. ent.money.total, 10, 10, quanta, "center")
    love.graphics.printf("Treasure in pocket: " .. ent.money.pocket_treasure, 10 + quanta, 10, quanta, "center")
    love.graphics.printf("Health", 10 + (2 * quanta), 10, quanta, "center")
    love.graphics.printf("Day progress", 10 + (3 * quanta), 10, quanta, "center")
    love.graphics.setFont(oldfont)

    if DEBUG then
        love.graphics.print("Last given: " .. ent.money.lastgiven, 10, 50)
        love.graphics.print("Total given: " .. ent.money.totalgiven, 10, 70)
        love.graphics.print("Last left over: " .. ent.money.lastleft, 10, 90)
        if ent.in_raid then
            love.graphics.print("Raid: Yes", 10, 110)
        else
            love.graphics.print("Raid: No", 10, 110)
        end
    end
end

return money