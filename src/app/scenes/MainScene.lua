
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
    mainLayer = display.newColorLayer(cc.c4b(0, 255, 0, 255))
    mainLayer:setContentSize(display.width, display.height)
   	mainLayer:addTo(self)
    uiLayer = display.newLayer()
    uiLayer:setContentSize(display.width, display.height)
    uiLayer:addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
