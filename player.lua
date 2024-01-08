player = {
    pos = vec2(64, 100),
    spr = 2,
    spd = 2,
    fire_delay = 3, -- prevent fire after start or over screens
    fire_r = 2,
    hp = 3,
    inv = 0,
    t = 0,

    flame_anim = new_anim("5,6,7,8,9"),

    coll_pos = function(self)
        local x, y = self.pos:unpack()
        return x + 1, y, x + 6, y + 7
    end
}

function reset_player()
    player.pos = vec2(64, 100)
    player.hp = 3
    player.fire_delay = 2
    player.inv = 0
    player.fire_r = 0
end

function move_player()
    local x, y = 0, 0
    local spd = player.spd

    local dir = vec2()
    if btn(0) then dir.x = -1 end
    if btn(1) then dir.x = 1 end
    if btn(2) then dir.y = -1 end
    if btn(3) then dir.y = 1 end

    dir:norm()
    player.pos += dir * player.spd

    player.spr = 2
    if dir.x < 0 then
        player.spr = 1
    elseif dir.x > 0 then
        player.spr = 3
    end
end

function damage_player()
    if player.inv > 0 then
        return false
    end
    player.hp -= 1
    player.inv = 60
    return true
end

function update_player()
    player.t += 1
    player.inv = max(player.inv - 1, 0)
    player.pos:mid(vec2(0, 5), vec2(120, 118))
end

function fire_player()
    if player.fire_delay > 0 then
        player.fire_delay -= 1
        return
    end

    if btn(5) then
        sfx(1)
        add_player_bullet(player.pos + vec2(2, -3))
        player.fire_delay = 5
        player.fire_r = 3
    end
end

function draw_player()
    -- collision_draw(player, 7)

    if player.inv > 0 then
        if player.t % 5 > 1 then
            spr(player.spr, player.pos.x, player.pos.y)
        end
    else
        spr(player.spr, player.pos.x, player.pos.y)
    end

    if player.fire_r > 0 then
        player.fire_r -= 1
        circfill(player.pos.x + 3, player.pos.y - 2, player.fire_r, 7)
    end
    spr(player.flame_anim:next(), player.pos.x, player.pos.y + 8)
end