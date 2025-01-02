
-- redesigned / optimized by sof1ik;

local say_list = {
    'list - TEST',
    'list - TEST1',
    'list - TEST2',
    'list - TEST3'
}

local total_head = 0
local text_size = 150

print('TrashTalk injected...')

mods.events:add_listener('player_death')
events.event:add(function (event)
    if event:get_name() ~= 'player_death' then
        return
    end

    local attackerId = event:get_pawn_from_id('attacker')

    if attackerId == entities.get_local_pawn() and event:get_bool('headshot') then
        total_head = total_head + 1
        game.engine:client_cmd(
            total_head >= 3 and string.format('say [FATALITY.WIN]: %s убил %d-х лохов в голову, обнуляем счетчик :)', gui.ctx.user.username, total_head) or string.format('say Хаха а как это так, я случайно снес тебе е**ло !%d!', total_head)
        )

        if total_head >= 3 then
            total_head = 0
        end
    end

    if attackerId and attackerId == entities.get_local_pawn() then
        game.engine:client_cmd(string.format('say %s', gui.ctx:find('rage>aimbot>general>nospread>settings>force'):get_value():get() and 'Уяяя' or say_list[math.random(#say_list)]))
    end
end)

events.present_queue:add(function (--[[ Gui Fuc ]])
    if not game.engine:in_game() then
        total_head = 0
    end

    if total_head ~= 0 and game.engine:in_game() then
        draw.surface.font = draw.fonts['gui_main'];
        draw.surface:add_text(draw.vec2(text_size, (text_size * 3)), string.format('Total Head Kill: %d', total_head), draw.color.white());
    end
end)
