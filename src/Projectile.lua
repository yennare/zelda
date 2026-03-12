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

end

function Projectile:update(dt)
    GameObject.update(self, dt)
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
    if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE or
        self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 or
        self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE or
        self.y + self.height >= BOTTOM_EDGE then

        self:breakPot()
    end
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    GameObject.render(self, adjacentOffsetX, adjacentOffsetY)
end

function Projectile:breakPot()

    self.thrown = false
    self.remove = true

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
