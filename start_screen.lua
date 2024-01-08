title_sprs = split("48,49,50,51,52,53")
start_press_delay = 20

function start_update()
    if start_press_delay > 0 then
        start_press_delay -= 1
        return
    end
    if btn(4) or btn(5) then
        start_press_delay = 20
        reset_game()
        mode = "game"
    end
end

function start_draw()
    cls(0)
    draw_starfield()

    for i = 1, #title_sprs do
        local start = 29
        if i > 2 then
            start = 28
        end
        spr(title_sprs[i], start + i * 9, 40)
    end

    local colors = split("5,5,6,6,7,7,6,6")
    print("press ❎ or 🅾️ to start", 18, 80, colors[1 + flr(time() * 20 % #colors)])
    print("by kusindia team with", 17, 120, 6)
    print("♥", 103, 120, 8)
end