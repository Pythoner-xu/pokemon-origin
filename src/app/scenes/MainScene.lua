local Player = import("..classes.player")  
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
   	mainLayer:addChild(tmx, 0, kTagTileMap)
end

function MainScene:onEnter()
    display.addSpriteFrames("heroin.plist", "heroin.png")
    local layer = tmx:getLayer('ground')
    local s = layer:getLayerSize()
    local down_walk_frames = display.newFrames("Red1_%02d.png", 1, 4)
    local down_walk = display.newAnimation(down_walk_frames, 0.5 / 4)
    down_walk:setRestoreOriginalFrame(true)
    display.setAnimationCache("down_walk", down_walk)
    player = Player.new()
    local images = {
        normal = "btn.png",
        pressed = "btn.png",
        disabled = "btn.png"
    }
    

    
    tmx:addChild(player, table.getn(tmx:getChildren()))
    player:retain()
    player:setAnchorPoint(cc.p(0,0))
    player:setPosition(layer:getTileAt(cc.p(10,10)):getPosition())
    tmx:reorderChild(player, 1);
    cc.ui.UIPushButton.new(images, {scale9 = true})
        :onButtonClicked(function(event)
            printf('click')
            player:doEvent("walk_down")
        end)
        :onButtonPressed(function(event)
            printf('pressed')
            
            
        end)
        :onButtonRelease(function(event)
            printf('released')
            player:doEvent("normal")
        end)
        :align(display.LEFT_BOTTOM, 12, 12)
        :addTo(self)
end

function MainScene:onExit()
end

return MainScene
