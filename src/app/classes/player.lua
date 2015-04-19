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

function Player:canDoEvent(event)
    return self.fsm:canDoEvent(event)
end

function Player:walk(distance_x, distance_y, joystick_w, joystick_h)
    if distance_x >= -joystick_w/4 and distance_x < joystick_w/4 and distance_y >= joystick_h/4 and self:canDoEvent("walk_up") then
        self:doEvent("walk_up") 
    end

    if distance_x >= -joystick_w/4 and distance_x < joystick_w/4 and distance_y < -joystick_h/4 and self:canDoEvent("walk_down") then
        self:doEvent("walk_down")
    end

    if distance_x < -joystick_w/4 and distance_y >= -joystick_h/4 and distance_y < joystick_h/4 and self:canDoEvent("walk_left") then
        self:doEvent("walk_left")
    end

    if distance_x >= joystick_w/4 and distance_y >= -joystick_h/4 and distance_y < joystick_h/4 and self:canDoEvent("walk_right") then
        self:doEvent("walk_right")
    end
end

function Player:addStateMachine()
    self.fsm = {}
    cc.GameObject.extend(self.fsm):addComponent("components.behavior.StateMachine"):exportMethods()
    self.fsm:setupState({
        initial = "idle",

        events = {
            {name = "walk_down", from = {"idle", "walk_up", "walk_left", "walk_right"}, to = "walk_down"},
            {name = "walk_up", from = {"idle", "walk_down", "walk_left", "walk_right"}, to = "walk_up"},
            {name = "walk_left", from = {"idle", "walk_up", "walk_down", "walk_right"}, to = "walk_left"},
            {name = "walk_right", from = {"idle", "walk_up", "walk_down", "walk_left"}, to = "walk_right"},
            {name = "normal", from = {"walk_down", "walk_up", "walk_left", "walk_right"}, to = "idle"}
        },

        callbacks = {
            onenteridle = function (event)
                printf('normal')
                self:stopAllActions()
            end,
            onenterwalk_down = function (event)       
                printf('walk_down')
                self:playAnimationForever(display.getAnimationCache("down_walk"))
                self:runAction(cc.RepeatForever:create(cc.MoveBy:create(0.5, cc.p(0, -48))))
            end,
            onenterwalk_up = function (event)
                printf('walk_up')
                self:playAnimationForever(display.getAnimationCache("up_walk"))
                self:runAction(cc.RepeatForever:create(cc.MoveBy:create(0.5, cc.p(0, 48))))
            end,
            onenterwalk_left = function (event)
                printf('walk_left')
                self:playAnimationForever(display.getAnimationCache("left_walk"))
                self:runAction(cc.RepeatForever:create(cc.MoveBy:create(0.5, cc.p(-48, 0))))
            end,
            onenterwalk_right = function (event)
                printf('walk_right')
                self:playAnimationForever(display.getAnimationCache("right_walk"))
                self:runAction(cc.RepeatForever:create(cc.MoveBy:create(0.5, cc.p(48, 0))))
            end
        }
    })
end

return Player