function love.load()
    video = love.graphics.newVideo("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    video:play()
end

function love.draw()
    love.graphics.draw(video, 0, 0)
end

function love.update(dt)
    if not video:isPlaying() then
        love.event.quit()
    end
end
