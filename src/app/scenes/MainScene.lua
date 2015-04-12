local Player = import("..classes.player")  
local wakeUpLate = false;
local mainLayer = nil;
local uiLayer = nil;
local chooseButton = {};
local tmx = nil;
local joystick = nil;
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
    uiLayer = display.newLayer()
    uiLayer:addTo(self, 99, uiKtaglayer)
end

function MainScene:onEnter()
    display.addSpriteFrames("heroin.plist", "heroin.png")
    local layer = tmx:getLayer('ground')
    local s = layer:getLayerSize()
    local down_walk_frames = display.newFrames("Red1_%02d.png", 1, 4)
    local down_walk = display.newAnimation(down_walk_frames, 0.5 / 4)
    local up_walk_frames = display.newFrames("Red1_")
    down_walk:setRestoreOriginalFrame(true)
    display.setAnimationCache("down_walk", down_walk)
    player = Player.new()
    

    
    tmx:addChild(player, table.getn(tmx:getChildren()), playerTag)
    player:retain()
    player:setAnchorPoint(cc.p(0,0))
    player:setPosition(layer:getTileAt(cc.p(10,10)):getPosition())
    tmx:reorderChild(player, 1);

    joystick = display.newSprite("btn.png")
    joystick:align(display.CENTER, joystick:getContentSize().width/2+12, joystick:getContentSize().height/2+12 )
    joystick:addTo(uiLayer)
--           printf('click')
--           player:doEvent("walk_down")
    joystick:setTouchEnabled(true)
    local bx = joystick:getPositionX()
    local by = joystick:getPositionY()
    local bw = joystick:getContentSize().width
    local bh = joystick:getContentSize().height
    joystick:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        printf("%s", event.name)
        if event.name == "began" then
            local dx = event.x - bx
            local dy = event.y - by
            if dx >= bw/4 and dy >= -bh/4 and dy <= bh/4 then
                player:doEvent("walk_down")
            end
        end

        if event.name == "moved" then
            local dx = math.abs(event.x - bx)
            local dy = math.abs(event.y - by)
            if dx > bw/2 or dy> bh/2 then
                player:doEvent("normal")
            end
        end

        if event.name == "ended" then
           player:doEvent("normal")
        end
        return true
    end)
       
end

function MainScene:onExit()
end

return MainScene
