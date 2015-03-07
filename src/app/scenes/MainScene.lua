
local wakeUpLate = false;
local mainLayer = nil;
local uiLayer = nil;
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    cc.ui.UILabel.new({
            UILabelType = 2, text = "Hello, World", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
    mainLayer = display.newColorLayer(cc.c4b(255, 255, 255, 255))
    	:setContentSize(display.width, display.height)
    	:addTo(self)
    uiLayer = display.newLayer()
    	:setContentSize(display.width, display.height)
    	:addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
