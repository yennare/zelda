
PlayerLiftPotState = Class{__includes = BaseState}



function PlayerLiftPotState:init(player)
    self.player = player
    local direction = self.player.direction
end

function PlayerLiftPotState:enter()

    
    self.player:changeAnimation('pot-' .. self.player.direction)

    Timer.after(0.15, function()
        self.player:changeState('idle')
    end)

end

function PlayerLiftPotState:update(dt)
    -- love.window.showMessageBox("debug", "lift update")
    self.player.currentAnimation:update(dt)
end


