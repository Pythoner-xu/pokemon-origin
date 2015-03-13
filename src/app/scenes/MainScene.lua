
local wakeUpLate = false;
local mainLayer = nil;
local uiLayer = nil;
local chooseButton = {};
local tmx = nil;
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.addSpriteFrames("sprites.plist", "sprites.png")
	chooseButton.RADIO_BUTTON_IMAGES = {
		on = "choose.png"
	}
	
	tmx = ccexp.TMXTiledMap:create('city1.tmx')
	tmx:align(display.CENTER, display.cx, display.cy)
    
    mainLayer = display.newColorLayer(cc.c4b(255, 255, 255, 255))
    mainLayer:setContentSize(display.width, display.height)
   	mainLayer:addTo(self)
    tmx:addTo(mainLayer)
end

function MainScene:onEnter()
    local layer = tmx:getLayer('ground')
    local tile = layer:getTileAt(cc.p(5,5))
    local frames = display.newFrames("flower%02d.png", 1, 4)
    local animation = display.newAnimation(frames, 1 / 4) -- 0.5 秒播放 8 桢
    display.setAnimationCache("flower", animation)
    tile:playAnimationForever(display.getAnimationCache("flower"))
end

function MainScene:onExit()
end

return MainScene
