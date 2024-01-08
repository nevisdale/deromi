mode = "start"

function _init()
    music(0)
    cartdata("kusindia_deromi_1")
    new_starfield()

    reset_game()
    high_score = dget(0) or 0
end

t = 0
function _update()
    t += 1
    if mode == "start" then
        start_update()
    elseif mode == "game" then
        music(-1, 1000)
        game_update()
    elseif mode == "over" then
        over_update()
    end
end

function _draw()
    if mode == "start" then
        start_draw()
    elseif mode == "game" then
        game_draw()
    elseif mode == "over" then
        over_draw()
    end
end