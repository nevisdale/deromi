vec2_mt = { x = 0, y = 0 }

function vec2(x, y)
    local vec = {
        x = x or 0,
        y = y or 0,

        copy = function(self)
            return vec2(self.x, self.y)
        end,

        mag = function(self)
            return sqrt(self.x * self.x + self.y * self.y)
        end,

        norm = function(self)
            local mag = self:mag()
            if mag != 0 then
                self.x /= mag
                self.y /= mag
            end
            return self
        end,

        unpack = function(self)
            return self.x, self.y
        end,

        mid = function(self, a, b)
            self.x = mid(self.x, a.x, b.x)
            self.y = mid(self.y, a.y, b.y)
        end
    }

    return setmetatable(vec, vec2_mt)
end

function vec2_mt.__add(a, b)
    return vec2(a.x + b.x, a.y + b.y)
end

function vec2_mt.__sub(a, b)
    return vec2(a.x - b.x, a.y - b.y)
end

function vec2_mt.__mul(a, b)
    if type(a) == "number" then
        return vec2(b.x * a, b.y * a)
    elseif type(b) == "number" then
        return vec2(a.x * b, a.y * b)
    end
    return a.x * b.x + a.y * b.y
end

function vec2_mt.__div(a, b)
    return vec2(a.x / b, a.y / b)
end

function vec2_mt.__tostring(a)
    return "(" .. a.x .. "," .. a.y .. ")"
end

function vec2_mt.__eq(a, b)
    return a.x == b.x, a.y == b.y
end

function vec2_mt:__unm()
    return vec2(-self.x, -self.y)
end