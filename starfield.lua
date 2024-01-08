starfield = {}

function new_starfield()
    for i = 1, 50 do
        local star = {
            clr = rnd({ 1, 5, 6 }),
            pos = vec2(flr(rnd(128)), flr(rnd(128))),
            spd = vec2(0, 1 + rnd(2)) * 2
        }
        add(starfield, star)
    end
end

function draw_starfield()
    foreach(
        starfield, function(star)
            pset(star.pos.x, star.pos.y, star.clr)
            star.pos += star.spd
            if star.pos.y > 128 then
                star.pos.y = 0
            end
        end
    )
end