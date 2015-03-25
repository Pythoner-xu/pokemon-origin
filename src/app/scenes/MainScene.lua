
local wakeUpLate = false;
local mainLayer = nil;
local uiLayer = nil;
local chooseButton = {};
local tmx = nil;
local player =nil;
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

CC_CONTENT_SCALE_FACTOR = function()
    return cc.Director:getInstance():getContentScaleFactor()
end


CC_POINT_PIXELS_TO_POINTS = function(pixels)
    return cc.p(pixels.x/CC_CONTENT_SCALE_FACTOR(), pixels.y/CC_CONTENT_SCALE_FACTOR())
end

CC_POINT_POINTS_TO_PIXELS = function(points)
    return cc.p(points.x*CC_CONTENT_SCALE_FACTOR(), points.y*CC_CONTENT_SCALE_FACTOR())
end

function MainScene:ctor()
	tmx = cc.TMXTiledMap:create('city1.tmx')
	tmx:align(display.CENTER, display.cx, display.cy)
    mainLayer = display.newColorLayer(cc.c4b(255, 255, 255, 255))
    mainLayer:setContentSize(display.width, display.height)
   	mainLayer:addTo(self)
   	mainLayer:addChild(tmx, 0, kTagTileMap)
end

function MainScene:onEnter()
    local layer = tmx:getLayer('ground')
    local s = layer:getLayerSize()
    local tamara = cc.Sprite:create("red.png")
    
    tmx:addChild(tamara, table.getn(tmx:getChildren()))
    tamara:retain()
    tamara:setAnchorPoint(cc.p(0,0))
    tamara:setPosition(layer:getTileAt(cc.p(6,5)):getPosition())
    local move = cc.MoveBy:create(10,cc.p(100, 50))
    local back = move:reverse()
    local seq = cc.Sequence:create(move, back)    
    tamara:runAction( cc.RepeatForever:create(seq))
    tmx:reorderChild(tamara, 0);
end

function MainScene:onExit()
end

return MainScene
