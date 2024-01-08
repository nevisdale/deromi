enemies = {}

function new_grayguy(pos, fire_count)
    add(
        enemies, {
            pos = pos or vec2(0, 0),
            spd = vec2(0, 1),
            anim = new_anim("25,26,27,28", 0.3),
            hp = 3,
            blink = 0,
            fire_count = fire_count or 0,
            fire_delay = 0,

            coll_pos = function(self)
                local x, y = self.pos:unpack()
                return x + 1, y + 1, x + 6, y + 6
            end,

            update = function(self)
                self.pos += self.spd
                self.blink -= 1
                local is_active = self.pos.y < 128 and self.hp > 0
                if is_active and self.fire_count > 0 then
                    self.fire_count -= 1
                    if self.fire_delay > 0 then
                        self.fire_delay -= 1
                        return is_active
                    end
                    add_enemy_bullet(self.pos + vec2(3, 4))
                    self.fire_delay = 60 - flr(scorek())
                end
                return is_active
            end,

            damage = function(self)
                self.hp -= 1
                self.blink = 2
                return self.hp <= 0
            end,

            draw = function(self)
                if self.blink > 0 then
                    for i = 1, 16 do
                        pal(i, 7)
                    end
                end
                spr(self.anim:next(), self.pos.x, self.pos.y)
                pal()
            end
        }
    )
end

function new_deathroll(pos, k)
    k = k or 4
    add(
        enemies, {
            pos = pos or vec2(0, 0),
            spd = vec2(rnd() - 0.5, rnd() - 0.5) * 3,
            anim = new_anim("41,42", 0.5),
            hp = 2,
            blink = 0,
            k = k,

            coll_pos = function(self)
                local x, y = self.pos:unpack()
                return x, y, x + 7, y + 7
            end,

            update = function(self)
                self.blink -= 1
                self.pos += self.spd
                if self.pos.x < 0 then
                    self.pos.x = 0
                    self.spd.x = abs(self.spd.x)
                end
                if self.pos.x > 120 then
                    self.pos.x = 120
                    self.spd.x = -abs(self.spd.x)
                end
                if self.pos.y < 5 then
                    self.pos.y = 5
                    self.spd.y = abs(self.spd.y)
                end
                if self.pos.y > 120 then
                    self.pos.y = 120
                    self.spd.y = -abs(self.spd.y)
                end
                if self.hp <= 0 and self.k > 0 then
                    new_deathroll(self.pos:copy(), flr(self.k / 2))
                    new_deathroll(self.pos:copy(), flr(self.k / 2))
                end
                return self.hp > 0
            end,

            damage = function(self)
                self.hp -= 1
                self.blink = 2
                return self.hp <= 0
            end,

            draw = function(self)
                if self.blink > 0 then
                    for i = 1, 16 do
                        pal(i, 7)
                    end
                end
                spr(self.anim:next(), self.pos.x, self.pos.y)
                pal()
            end
        }
    )
end

function damage_enemy(en)
    return en:damage()
end

function update_enemies()
    foreach(
        enemies, function(en)
            if not en:update() then
                del(enemies, en)
            end
        end
    )
end

function draw_enemies()
    foreach(
        enemies, function(en)
            en:draw()
        end
    )
end