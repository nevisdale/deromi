player_bullets = {}

function add_player_bullet(pos)
    add(
        player_bullets, {
            pos = pos or vec2(0, 0),
            spd = vec2(0, -4),
            spr = 17,

            coll_pos = function(self)
                local x, y = self.pos:unpack()
                return x, y, x + 3, y + 3
            end
        }
    )
end

enemy_bullets = {}

function add_enemy_bullet(pos)
    local spd = player.pos - pos
    spd = spd:norm() * 2

    add(
        enemy_bullets, {
            pos = pos,
            spd = spd,
            anim = new_anim("32,33", 1),

            coll_pos = function(self)
                local x, y = self.pos:unpack()
                return x, y, x + 2, y + 2
            end
        }
    )
end

function draw_bullets()
    foreach(
        player_bullets, function(b)
            spr(b.spr, b.pos.x, b.pos.y)
            b.pos += b.spd
            if b.pos.y < 0 or b.pos.y > 128 then
                del(player_bullets, b)
            end
        end
    )

    foreach(
        enemy_bullets, function(b)
            spr(b.anim:next(), b.pos.x, b.pos.y)
            b.pos += b.spd
            if b.pos.y < 0 or b.pos.y > 128 then
                del(enemy_bullets, b)
            end
        end
    )
end