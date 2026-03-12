
PlayerLiftPotState = Class{__includes = BaseState}



function PlayerLiftPotState:init(player)
    -- print('LIFT INIT')
    self.player = player
    local direction = self.player.direction
end

function PlayerLiftPotState:enter()
    -- print('LIFT ENTER')
    self.player.busy = true

    self.player:changeAnimation('pot-' .. self.player.direction)

    Timer.after(0.3, function()
        self.player.busy = false
        self.player:changeState('idle')
    end)

end

function PlayerLiftPotState:update(dt)
    -- love.window.showMessageBox("debug", "lift update")
    -- print(self.player.currentAnimation.currentFrame)
    -- self.player.currentAnimation:update(dt)
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end
end

function PlayerLiftPotState:render()

    local anim = self.player.currentAnimation

    love.graphics.draw(
        gTextures[anim.texture],
        gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX),
        math.floor(self.player.y - self.player.offsetY)
    )

end
