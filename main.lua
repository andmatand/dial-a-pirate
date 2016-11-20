function love.load()
    back = {
        image = love.graphics.newImage('assets/back.png'),
        position = {x = 0, y = 0},
        offset = {x = 523, y = 517},
        r = 0
    }
    front = {
        image = love.graphics.newImage('assets/front.png'),
        position = {x = 0, y = 0},
        offset = {x = 378, y = 370},
        r = 0
    }

    adjust_scale()
end

function adjust_scale()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    if screenWidth < screenHeight then
        scale = screenWidth / back.image:getWidth()
    else
        scale = screenHeight / back.image:getHeight()
    end

    back.position.x = screenWidth / 2
    back.position.y = screenHeight / 2
    front.position.x = screenWidth / 2
    front.position.y = screenHeight / 2
end

function love.resize()
    adjust_scale()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        drag = {
            initialAngle = getAngle(x, y),
            initialDiscRotation = back.r
        }
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        drag = nil
    end
end

function getAngle(clickX, clickY)
    local x = clickX - back.position.x
    local y = clickY - back.position.y

    return math.atan2(y, x)
end

function love.mousemoved(x, y)
    if love.mouse.isDown(1) and drag then
        local currentAngle = getAngle(x, y)
        back.r = drag.initialDiscRotation + currentAngle - drag.initialAngle
    end
end

function love.draw()
    for _, disc in pairs({back, front}) do
        love.graphics.draw(
            disc.image,
            disc.position.x, disc.position.y,
            disc.r,
            scale, scale,
            disc.offset.x, disc.offset.y)
    end
end
