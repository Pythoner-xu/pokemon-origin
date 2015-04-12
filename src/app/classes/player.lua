local Player = class("Player", function ()
    return display.newSprite("#Red1_01.png")
end)

function Player:ctor()
    self:addStateMachine()
    display.addSpriteFrames("heroin.plist", "heroin.png")
end

function Player:doEvent(event)
    self.fsm:doEvent(event)
end

function Player:addStateMachine()
    self.fsm = {}
    cc.GameObject.extend(self.fsm):addComponent("components.behavior.StateMachine"):exportMethods()
    self.fsm:setupState({
        initial = "idle",

        events = {
            {name = "walk_down", from = {"idle"}, to = "walk_down"},
            {name = "normal", from = {"walk_down"}, to = "idle"}
        },

        callbacks = {
            onenteridle = function (event)
                printf('normal')
                self:stopAllActions()
            end,
            onenterwalk_down = function (event)
                local move = cc.MoveBy:create(0.5,cc.p(0, -48)) 
                printf('walk_down')
                self:moveBy(2,0,-48)
                self:playAnimationForever(display.getAnimationCache("down_walk"))
                self:runAction(cc.RepeatForever:create(move))
            end
        }
    })
end

return Player