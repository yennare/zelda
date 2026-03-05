--[[
    CS50 2D
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{__includes = GameObject}

function Projectile:init(def)
    GameObject.init(self, def)
end

function Projectile:update(dt)
    GameObject.init(self, dt)
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    GameObject.render(self)
end