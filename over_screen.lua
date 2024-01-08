over_sprs = split("51,56,54,55")
game_sprs = split("57,58,59,54")
over_press_delay = 20

function over_update()
    if over_press_delay > 0 then
        over_press_delay -= 1
        return
    end
    if btn(4) or btn(5) then
        reset_game()
        over_press_delay = 20
        mode = "game"
    end
end

function over_draw()
    cls(0)

    draw_starfield()
    draw_ui()

    for i = 1, #game_sprs do
        local start = 38
        spr(game_sprs[i], start + i * 9, 31)
    end

    for i = 1, #over_sprs do
        local start = 38
        if i > 3 then
            start = 37
        end
        spr(over_sprs[i], start + i * 9, 40)
    end

    print("high score:" .. high_score, 0, 7, 8)
    if score > high_score then
        high_score = score
        dset(0, high_score)
    end
    local colors = split("5,5,6,6,7,7,6,6")
    print("press ❎ or 🅾️ to start", 18, 80, colors[1 + flr(time() * 20 % #colors)])
end