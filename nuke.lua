
-- by sof1ik;

local url_pitch = 'rage>anti-aim>angles>pitch'
local url_antiaim = 'rage>anti-aim>angles>anti-aim'

print('Nuke injected...')

mods.events:add_listener('round_end')
mods.events:add_listener('round_freeze_end')
events.event:add(function (event)
    if event:get_name() == 'round_end' then
        gui.ctx:find(url_antiaim):set_value(false)
    end

    if event:get_name() == 'round_freeze_end' then
        gui.ctx:find(url_antiaim):set_value(true)
    end
end)

events.present_queue:add(function (--[[ Gui Fuc ]])
    if game.engine:in_game() then
        local isMap = game.global_vars.map_name

        if string.find(isMap, 'de_nuke', 1, true) then
            --print(string.format('map - %s', isMap));
            gui.ctx:find(url_pitch):get_value():disable_hotkeys()
        end
    end
end)
