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
    local layer = tmx:getLayer('ground')
    --加载文件
    display.addSpriteFrames("heroin.plist", "heroin.png")
    
    --创建动画
    local left_walk = display.newAnimation(display.newFrames("Red1_%02d.png", 5, 4), 0.5/4)
    local right_walk = display.newAnimation(display.newFrames("Red1_%02d.png", 9, 4), 0.5/4)
    local down_walk = display.newAnimation(display.newFrames("Red1_%02d.png", 1, 4), 0.5 / 4)
    local up_walk = display.newAnimation(display.newFrames("Red1_%02d.png", 13, 4), 0.5/4)
    down_walk:setRestoreOriginalFrame(true)
    up_walk:setRestoreOriginalFrame(true)
    left_walk:setRestoreOriginalFrame(true)
    right_walk:setRestoreOriginalFrame(true)

    --添加缓存
    display.setAnimationCache("up_walk", up_walk)
    display.setAnimationCache("down_walk", down_walk)
    display.setAnimationCache("left_walk", left_walk)
    display.setAnimationCache("right_walk", right_walk)

    --添加主角
    player = Player.new()
    tmx:addChild(player, table.getn(tmx:getChildren()), playerTag)
    player:retain()
    player:setAnchorPoint(cc.p(0,0))
    player:setPosition(layer:getTileAt(cc.p(10,10)):getPosition())
    tmx:reorderChild(player, 1);

    --添加方向键
    joystick = display.newSprite("btn.png")
    joystick:align(display.CENTER, joystick:getContentSize().width/2+12, joystick:getContentSize().height/2+12 )
    joystick:addTo(uiLayer)
    joystick:setTouchEnabled(true)

    --获得方向键位置和宽度
    local joystick_x = joystick:getPositionX()
    local joystick_y = joystick:getPositionY()
    local joystick_w = joystick:getContentSize().width
    local joystick_h = joystick:getContentSize().height

    --获取方向键触摸事件 
    joystick:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        printf("%s", event.name)
        local distance_x = event.x - joystick_x
        local distance_y = event.y - joystick_y
        if event.name == "began" then
            player:walk(distance_x, distance_y, joystick_w, joystick_h)
        end

        if event.name == "moved" then
            if math.abs(distance_x) > joystick_w/2 or math.abs(distance_y)> joystick_h/2 then
                if player:canDoEvent("normal") then
                    player:doEvent("normal")
                    return true
                end
            end
            player:walk(distance_x, distance_y, joystick_w, joystick_h)
        end

        if event.name == "ended" then
            if player:canDoEvent("normal") then
                player:doEvent("normal")
            end
        end
        return true
    end)
       
end

function MainScene:onExit()
end

return MainScene
