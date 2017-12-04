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

    if ent.current_turn_len >= daylen and GS.current() ~= scripts.gamestates.overworld then
        if ent.money.total + ent.money.pocket_treasure >= ent.money.lastgiven * 1.05 then
            DOSWITCH = true
        else
            money.next_turn()
        end
    end

    if ent.current_second_progress >= 1 then
        ent.current_second_progress = 0
        money.second()
    end
end

money.give_to_son = function(amount)
    amount = amount or tonumber(txt)
    if not amount then return end
    amount = math.floor(amount)

    local ent = money.get_money_ent()
    if not ent then return end

    print(amount .. ":" .. ent.money.total)
    if amount < ent.money.lastgiven * 1.05 then
        ent.dialog_status = "> I really need more than that dad!"
        return false
    end
    if amount > ent.money.total then
        ent.dialog_status = "< I am trying to give you, but I can't give you more than I have!"
        return false
    end
    if ent.son.happy_this_turn then
        ent.dialog_status = "> I don't need any more today!"
        return false
    end
    ent.dialog_status = nil
    ent.son.happy_this_turn = true
    ent.money.lastgiven = amount
    ent.money.totalgiven = ent.money.totalgiven + ent.money.lastgiven
    ent.money.total = ent.money.total - amount
    ent.money.lastleft = ent.money.total
    LAST_RANDOM = nil

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

    ent.dialog_status = nil
    ent.in_raid = true
    LAST_RANDOM = nil
end

money.end_raid = function(alive)
    local ent = money.get_money_ent()
    if not ent then return end
    if not ent.in_raid then return end

    if alive then
        ent.money.total, ent.money.pocket_treasure = ent.money.total + ent.money.pocket_treasure, 0
    else
        ent.money.pocket_treasure = 0
        if ent.money.total  < ent.money.lastgiven * 1.05 then
            money.next_turn()
        end
    end

    ent.last_turn_alive_or_new_day = alive

    ent.in_raid = false
    ent.raid_leve = ent.raid_level + 1
    LAST_RANDOM = nil
end

money.get_last_left = function()
    local ent = money.get_money_ent()
    if not ent then return end
    return ent.money.lastleft
end

money.next_turn = function()
    local ent = money.get_money_ent()
    if not ent then return end

    HOARD.current_turn_len = 0
    ent.current_turn_len = 0

    if not ent.son.happy_this_turn then
        GS.switch(scripts.gamestates.gameover)
        return false
    end

    ent.son.happy_this_turn = false
    ent.last_turn_alive_or_new_day = true
    ent.raid_level = ent.raid_level + 1
    ent.dialog_status = nil
    LAST_RANDOM = nil
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

money.dialog = {}

money.dialog.messages = {
    open_message = "> Dad! Dad! I got accepted to college!\n< That’s wonderful, son!\n> I kinda need money for books though,\n\tcan you give me some from your hoard...?",
    hoard_strapped = "< I need to get more gold, the hoard looks way too small...\n< Those pesky dwarves probably stole some.\n< They will burn.",
    son_happy_message = "> Thank you, Dad!\n< If you need more, just tell me.\n> Oh, this will be enough for now",
    son_happy_message_later = "< Here you go.\n< Be well, okay?\n> I will, thanks Dad!",
    random_money_quest = "> Hey Dad, I’m running kind of short on money, could you give me some more?\n< Of course! How much do you need?\n> A little bit more than last time should do.",
    finished_hoard = "> Come on, it’s not gonna be that much, I promise!\n< Okay then, I’ll give you some.",
    random = {
        "> Hey Dad, how are you? I kinda need some more gold for housing.",
        "> I met this girl, and I wanna take her to prom, but I don’t have a suit, can I have some gold?",
        "> Dad, people are making fun of my clothes, can I buy new ones?",
        "> Goooooooooold, I want goooooooold!",
        "> That’s not enough, Dad, I need more!",
        "> If you would really care about me you’d give more.",
        "> You don’t like me, do you?",
        "> This’ll barely be enough! Can’t you give more?",
        "> That’s it, I’m moving out. Goodbye Dad. See you never.",
        "< BUUUUUUURRRRN!",
        "< FOOLISH MORTALS!",
        "< STAY OFF MY HOARD!",
        "< MY HOARD, MY GOLD!",
        "< DIE!",
        "< MY SON WILL GET HIS PHD!",
        "< I WILL PUT MY KID THROUGH COLLEGE!",
    }
}

money.dialog.get = function()
    local ent = money.get_money_ent()
    if ent == nil then return "" end
    local messages = money.dialog.messages
    if not LAST_RANDOM then LAST_RANDOM = math.random(1, 16) end

    if ent.dialog_status then
        return ent.dialog_status
    elseif ent.money.total == 0 and ent.raid_level == 1 then
        return messages.open_message
    elseif ent.raid_level == 1 and ent.son.happy_this_turn then
        return messages.son_happy_message
    elseif ent.son.happy_this_turn then
        return messages.son_happy_message_later
    elseif ent.money.total < ent.money.lastgiven * 1.05 then
        return messages.hoard_strapped
    elseif ent.raid_level == 1 then
        return messages.finished_hoard
    elseif ent.money.total >= ent.money.lastgiven * 1.05 and ent.raid_level % 3 == 0 then
        return messages.random_money_quest
    else
        return messages.random[LAST_RANDOM]
    end
end

return money