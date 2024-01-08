score = 0
high_score = 0

function scorek()
    return 1 + score / 15.0
end

function reset_game()
    reset_player()
    player_bullets = {}
    enemy_bullets = {}
    enemies = {}
    score = 0
    particals = {}
end

function game_update()
    move_player()
    fire_player()
    update_player()
    update_enemies()

    enmey_spawn()

    collision_player_enemies(function(player, en)
        if damage_player() then
            sfx(2)
            new_explosion(player.pos:copy())
            new_wave(player.pos:copy(), 8, 7)
        end
    end)

    collision_bullet_enemies(function(bull, en)
        sfx(0)
        new_spark(bull.pos:copy())
        new_wave(bull.pos:copy(), 3, 9)
        if damage_enemy(en) then
            sfx(3)
            new_explosion(en.pos:copy())
            new_wave(bull.pos:copy(), 8, 7)
            score += 1
        end
        del(player_bullets, bull)
    end)

    collision_bullet_player(function(bull, player)
        if damage_player() then
            sfx(2)
            new_explosion(player.pos:copy())
            new_wave(player.pos:copy(), 8, 7)
        end
        del(enemy_bullets, bull)
    end)

    if player.hp <= 0 then
        sfx(10)
        mode = "over"
    end
end

function enmey_spawn()
    local k = flr(scorek())
    local rnd_pod = vec2(3 + rnd(117), 0)

    if t % (45 - k) == 0 then
        new_grayguy(rnd_pod:copy(), k)
    end
    if t % (270 - k) == 0 then
        new_deathroll(rnd_pod:copy(), flr(scorek() - 1))
    end
end

function game_draw()
    cls(0)
    draw_starfield()
    draw_player()
    draw_enemies()
    draw_particals()
    draw_bullets()
    draw_ui()
end

function draw_ui()
    rectfill(0, 0, 128, 4, 0)
    print("score:" .. score, 0, 0, 12)
    for i = 1, player.hp do
        spr(13, 125 - i * 10, 0)
    end
end

-- utils
function draw_grid()
    rect(0, 0, 64, 64, 7)
    rect(64, 0, 127, 64, 7)
    rect(0, 64, 64, 127, 7)
    rect(64, 64, 127, 127, 7)
end