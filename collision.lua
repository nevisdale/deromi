-- return true is overlap
function overlap(a, b)
    a_left, a_top, a_right, a_bottom = a:coll_pos()
    b_left, b_top, b_right, b_bottom = b:coll_pos()

    if a_left > b_right or b_left > a_right or a_top > b_bottom or b_top > a_bottom then
        return false
    end

    return true
end

function collision_player_enemies(respond)
    foreach(
        enemies, function(en)
            if overlap(player, en) then
                respond(player, en)
            end
        end
    )
end

function collision_bullet_enemies(respond)
    foreach(
        enemies, function(en)
            foreach(
                player_bullets, function(bull)
                    if overlap(bull, en) then
                        respond(bull, en)
                    end
                end
            )
        end
    )
end

function collision_bullet_player(respond)
    foreach(
        enemy_bullets, function(bull)
            if overlap(bull, player) then
                respond(bull, player)
            end
        end
    )
end

function collision_draw(a, color)
    local x1, y1, x2, y2 = a:coll_pos()
    rectfill(x1, y1, x2, y2, color or 7)
end