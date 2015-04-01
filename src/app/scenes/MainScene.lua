
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
    display.addSpriteFrames("heroin.plist", "heroin.png")
    local layer = tmx:getLayer('ground')
    local s = layer:getLayerSize()
    local tamara = display.newSprite("#Red1_01.png")
    local images = {
        normal = "btn.png",
        pressed = "btn.png",
        disabled = "btn.png"
    }
    local down_walk_frames = display.newFrames("Red1_%02d.png", 1, 4)
    local down_walk = display.newAnimation(down_walk_frames, 0.5 / 4)
    down_walk:setRestoreOriginalFrame(true)
    display.setAnimationCache("down_walk", down_walk)

    
    tmx:addChild(tamara, table.getn(tmx:getChildren()))
    tamara:retain()
    tamara:setAnchorPoint(cc.p(0,0))
    tamara:setPosition(layer:getTileAt(cc.p(10,10)):getPosition())
    local move = cc.MoveBy:create(2,cc.p(0, 48)) 
    tmx:reorderChild(tamara, 1);
    cc.ui.UIPushButton.new(images, {scale9 = true})
        :onButtonClicked(function(event)
            printf('click')
        end)
        :onButtonPressed(function(event)
            printf('pressed')
            tamara:playAnimationOnce(display.getAnimationCache("down_walk"))
            tamara:moveBy(0.5,0 , -48)
        end)
        :onButtonRelease(function(event)
            printf('released')
        end)
        :align(display.LEFT_BOTTOM, 12, 12)
        :addTo(self)
end

function MainScene:onExit()
end

return MainScene
