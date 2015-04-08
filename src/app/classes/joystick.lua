local bw = nil
local bh = nil
local bx = nil
local by = nil
local Joystick = class("Joystick", function ()
    return display.newSprite("btn.png")
end)

function Joystick:ctor()
    
    bw = self:getContentSize().width
    bh = self:getContentSize().height
    self:center()
    self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        bx = self:getPositionX()
        by = self:getPositionY()
        
        if event.name == "began" then
            self:onTouchBegan(event.x, event.y)
            return true
        end

        if event.name == "moved" then
            printf("%s,x %0.2f, y%0.2f, bx%0.2f,by %0.2f, bw%0.2f,bh %0.2f", event.name, event.x, event.y,bx,by,bw,bh)

            self:onTouchMoved(event.x, event.y)
        end

        if event.name == "ended" then
            self:onTouchEnded(event.x, event.y)
        end

    end)
end

function Joystick:onTouchBegan(x, y)
    local dx = x - bx
    local dy = y - by
    if dx >= bw/4 and dy >= -bh/4 and dy <= bh/4 then
        player:doEvent("walk_down")
    end
end

function Joystick:onTouchMoved(x, y)
    -- body
end

function Joystick:onTouchEnded(x, y)
end

return Joystick