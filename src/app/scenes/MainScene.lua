
local wakeUpLate = false;
local mainLayer = nil;
local uiLayer = nil;
local chooseButton = {};
local tmx = nil;
local player =nil;
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	tmx = cc.TMXTiledMap:create('city1.tmx')
	tmx:align(display.CENTER, display.cx, display.cy)
    mainLayer = display.newColorLayer(cc.c4b(255, 255, 255, 255))
    mainLayer:setContentSize(display.width, display.height)
   	mainLayer:addTo(self)
    tmx:addTo(mainLayer)
    
end

function MainScene:onEnter()
    local layer = tmx:getLayer('ground')
    local s = layer:getLayerSize()
    printf(s.width)
    printf(s.height)
    local tamara = cc.Sprite:create("red.png")
    local p = tamara:getPosition()
    p = CC_POINT_POINTS_TO_PIXELS(p)
    local newZ = -(p.y + 32) / 16
    tamara:setVertexZ(newZ)

end

function MainScene:onExit()
end

return MainScene
