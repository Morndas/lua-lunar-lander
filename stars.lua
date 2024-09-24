local stars = {}
local starSpeed = 300

function stars.init()
    for i = 1, 50 do
        stars.addStar(i*10)
    end
end

function stars.addStar(y)
    local star = {}
    star.x = math.random(0, love.graphics.getWidth())
    star.y = y
    table.insert(stars, star)
end

function stars.update(dt)
    for idxStar, star in ipairs(stars) do
        star.y = star.y + starSpeed * dt
        
        if star.y > love.graphics.getHeight() then
            table.remove(stars, idxStar)
        end
    end

    stars.addStar(10)
end

function stars.draw()
    for idxStar, star in ipairs(stars) do
        love.graphics.circle("fill", star.x, star.y, 1)
    end
end

return stars