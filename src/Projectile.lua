--[[
    CS50 2D
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{__includes = GameObject}

function Projectile:init(def, x, y)
    GameObject.init(self, def, x, y)
   
    grabbed = def.grabbed
    thrown = def.thrown
   
    self.player = player
    self.carrier = nil
    self.dx = 0
    self.dy = 0
    self.speed = 120 

    self.distanceTravelled = 0  
    self.maxDistance = TILE_SIZE * 4

    -- setting up particle system
    self.psystem = love.graphics.newParticleSystem(gTextures['hearts'], 64)
    -- lasts between 0.5-1 seconds seconds
    self.psystem:setParticleLifetime(0.5, 1)
    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward 
    self.psystem:setLinearAcceleration(-15, 0, 15, 80)
    -- spread of particles; normal looks more natural than uniform
    self.psystem:setEmissionArea('normal', 10, 10)
    self.psystem:setSpeed(40, 120)
    self.psystem:setSpread(math.rad(360))
    self.psystem:setSizes(1, 0.3)

end

function Projectile:update(dt)
    GameObject.update(self, dt)
    
    self.psystem:update(dt)

    if self.grabbed and self.carrier then
        self.x = self.carrier.x  
        self.y = self.carrier.y - 10
    end
    if love.keyboard.wasPressed('space') and self.grabbed then
        self:throw()
    end
    if self.thrown then
        local moveX = self.dx * dt
        local moveY = self.dy * dt

        self.x = self.x + moveX
        self.y = self.y + moveY

        self.distanceTravelled = self.distanceTravelled + math.abs(moveX) + math.abs(moveY)
    end
    if self.distanceTravelled >= self.maxDistance then
        self:breakPot()
        
    end
    -- for k, entity in pairs(room.entities) do
    --     if not entity.dead and self:collides(entity) then

    --         entity:damage(1)
    --         entity.dead = true

    --         self:breakPot()
    --     end
    -- end
    if not self.carrier then
        if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE or
            self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 or
            self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE or
            self.y + self.height >= BOTTOM_EDGE then

            self:breakPot()
           
        end
    end
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    GameObject.render(self, adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(self.psystem, adjacentOffsetX, adjacentOffsetY)
end

function Projectile:breakPot()

    self.thrown = false
    self.remove = true

    self.psystem:setColors(
        1, 1, 0.5, 1,
        1, 0.5, 0, 1,
        0.5, 0.2, 0, 0
        )
    self.psystem:setPosition(self.x + 8, self.y + 8)
    self.psystem:start()
    self.psystem:emit(64)

    -- love.window.showMessageBox("debug", "EMIT PARTICLES")
    -- print('EMIT PARTICLES')
end

function Projectile:throw()
    self.grabbed = false
    self.thrown = true  
    self.carrier.carrying = false

    local dir = self.carrier.direction 

    if dir == 'left' then
        self.dx = -self.speed
        self.dy = 0
    elseif dir == 'right' then
        self.dx = self.speed
        self.dy = 0
    elseif dir == 'up' then
        self.dx = 0
        self.dy = -self.speed
    else
        self.dx = 0
        self.dy = self.speed
    end

    self.carrier = nil
end

function Projectile:grab(player)
-- print('ENTER LIFT STATE')
    -- player:changeState('lift-pot')
    self.grabbed = true 
    self.carrier = player
    self.carrier.carrying = true    
end


