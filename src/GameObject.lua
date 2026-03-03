--[[
    CS50 2D
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    -- self.consumable = def.consumable
    -- default empty collision callback
    self.onCollide = function() end
    -- self.onConsume = function() 
    --     for k, object in pairs(self.objects) do
    --         if object:collides(self) then

    --             -- 🔥 Caso consumable
    --             if object.consumable then
    --                 object:onConsume(self, object)
    --                 table.remove(self.objects, k)
    --             end
    --         end
    --     end
    -- end
end

function GameObject:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)
end

function GameObject:update(dt)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    local frame = self.frame

    if self.states and self.states[self.state] and self.states[self.state].frame then
        frame = self.states[self.state].frame
    end

    love.graphics.draw(
        gTextures[self.texture],
        gFrames[self.texture][frame],
        self.x + adjacentOffsetX,
        self.y + adjacentOffsetY
    )
end