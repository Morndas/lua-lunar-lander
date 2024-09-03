-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

local lander = {}
lander.x = 0
lander.y = 0
lander.angle = -90
lander.vx = 0
lander.vy = 0
lander.speed_x = 4
lander.speed_y = 4
lander.rotation_speed = 130
lander.img = love.graphics.newImage("assets/ship.png")
lander.engineImg = love.graphics.newImage("assets/engine.png")
lander.isEngineOn = false

local gravity = 0.6

local isGameOver = false

function love.load()
  -- Positionne le vaisseau au centre de la fenêtre
  lander.x = love.graphics.getWidth()/2
  lander.y = love.graphics.getHeight()/2
end


-- TODO : relancer une partie avec états par défaut (reset la position, angle et vélocité du vaisseau)
function love.update(dt)
  -- On applique le coefficient de gravité à l'inertie du vaisseau
  lander.vy = lander.vy + (gravity * dt)
  
  -- Gestion des inputs du joueur
  if love.keyboard.isDown("left") then
    lander.angle = lander.angle - (lander.rotation_speed * dt)
  end
  if love.keyboard.isDown("right") then
    lander.angle = lander.angle + (lander.rotation_speed * dt)
  end
  if love.keyboard.isDown("up") then
    lander.isEngineOn = true
    local angleRadian = math.rad(lander.angle)
    local force_x = math.cos(angleRadian) * (lander.speed_x * dt)
    local force_y = math.sin(angleRadian) * (lander.speed_y * dt)
    
    lander.vx = lander.vx + force_x
    lander.vy = lander.vy + force_y
  else
    lander.isEngineOn = false
  end
  
  -- Calcul de la nouvelle position du vaisseau
  lander.x = lander.x + lander.vx
  lander.y = lander.y + lander.vy
  
  local hasPassedLeftEdge = lander.x < 0
  local hasPassedRightEdge = (lander.x + lander.img:getWidth()) > love.graphics.getWidth()
  local hasPassedBottomEdge = lander.y < 0
  local hasPassedTopEdge = lander.y > love.graphics.getHeight() - lander.img:getHeight()
  
  if hasPassedBottomEdge or hasPassedTopEdge or hasPassedLeftEdge or hasPassedRightEdge then
    isGameOver = true
  end
end

function love.draw()
  if isGameOver then
    local gameOverMessage = "Vous avez perdu ! Recommencer ?"
    local gameOverMessageWidth = love.graphics.getFont():getWidth(gameOverMessage)
    love.graphics.print(gameOverMessage, (love.graphics.getWidth()/2 - gameOverMessageWidth/2), 0)
  else
    love.graphics.draw(lander.img, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.img:getWidth()/2, lander.img:getHeight()/2)
    if lander.isEngineOn then
      love.graphics.draw(lander.engineImg, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.engineImg:getWidth()/2, lander.engineImg:getHeight()/2)
    end
  end
end