particals = {}

function new_spark(pos)
    add(
        particals, {
            pos = pos,
            spd = vec2(rnd() - 0.5, -rnd()) * 5,
            ttl = 3,
            is_active = true,

            draw = function(self)
                if self.ttl < 1 then
                    self.is_active = false
                end
                self.ttl -= 1
                self.pos += self.spd
                pset(self.pos.x, self.pos.y, 7)
            end
        }
    )
end

function new_explosion(pos, typ)
    get_color = function(p)
        if p.ttl < 2 then return 5 end
        if p.ttl < 3 then return 8 end
        if p.ttl < 5 then return 9 end
        if p.ttl < 6 then return 7 end
    end

    for i = 1, 5 do
        add(
            particals, {
                pos = pos,
                spd = vec2(rnd() - 0.5, rnd() - 0.5) * 2,
                r = 7,
                ttl = 10,
                is_active = true,

                draw = function(self)
                    if self.r < 0 and self.ttl < 1 then
                        self.is_active = false
                    end
                    self.pos += self.spd
                    self.r -= 0.5
                    self.ttl -= 1
                    circfill(self.pos.x, self.pos.y, self.r, get_color(self))
                end
            }
        )
    end
end

function new_wave(pos, r, color)
    add(
        particals, {
            pos = pos,
            max_r = r or 3,
            r = 2,
            clr = color or 7,
            is_active = true,

            draw = function(self)
                if self.r >= self.max_r then
                    self.is_active = false
                end
                self.r += 1
                circ(self.pos.x, self.pos.y, self.r, self.clr)
            end
        }
    )
end

function draw_particals()
    foreach(
        particals, function(p)
            if p.is_active == false then
                del(particals, p)
            end
            p:draw()
        end
    )
end