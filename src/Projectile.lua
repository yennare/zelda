--[[
    CS50 2D
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{__includes = GameObject}

function Projectile:init(def, x, y)
    GameObject.init(self, def, x, y)
    self.player = player
    grabbed = def.grabbed

end

function Projectile:update(dt)
    GameObject.update(self, dt)
    if self.grabbed and self.carrier then
        self.x = self.carrier.x  
        self.y = self.carrier.y - 10
    end

end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    GameObject.render(self, adjacentOffsetX, adjacentOffsetY)
end

function Projectile:grab(player)
    self.grabbed = true 
    self.carrier = player
end
