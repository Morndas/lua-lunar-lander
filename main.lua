-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

local lander = {}
lander.x = 0
lander.y = 0
lander.angle = -90
lander.vx = 0
lander.vy = 0
lander.speed_x = 3
lander.speed_y = 3
lander.img = love.graphics.newImage("assets/ship.png")
lander.engineImg = love.graphics.newImage("assets/engine.png")

local gravity = 0.6

local isEngineOn = false


function love.load()
  -- Positionne le vaisseau au centre de la fenêtre
  lander.x = love.graphics.getWidth()/2
  lander.y = love.graphics.getHeight()/2
end

function love.update(dt)
  -- On applique le coefficient de gravité à l'inertie du vaisseau
  lander.vy = lander.vy + (gravity * dt)

  
  -- Gestion des inputs du joueur
  if love.keyboard.isDown("left") then
    lander.angle = lander.angle - (90 * dt)
  end
  if love.keyboard.isDown("right") then
    lander.angle = lander.angle + (90 * dt)
  end
  if love.keyboard.isDown("up") then
    isEngineOn = true
    local angleRadian = math.rad(lander.angle)
    local force_x = math.cos(angleRadian) * (lander.speed_x * dt)
    local force_y = math.sin(angleRadian) * (lander.speed_x * dt)
    
    lander.vx = lander.vx + force_x
    lander.vy = lander.vy + force_y
  else
    isEngineOn = false
  end
  
  -- Déplacement du vaisseau
  lander.x = lander.x + lander.vx
  lander.y = lander.y + lander.vy
end

function love.draw()
  love.graphics.draw(lander.img, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.img:getWidth()/2, lander.img:getHeight()/2)
  if isEngineOn then
    love.graphics.draw(lander.engineImg, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.engineImg:getWidth()/2, lander.engineImg:getHeight()/2)
  end
end