local Player = import("..classes.player") 
local scheduler = cc.Director:getInstance():getScheduler()
local wakeUpLate = false;
local mainLayer = nil;
local uiLayer = nil;
local player = nil;
local chooseButton = {};
local city1 = nil;
local joystick = nil;
local player =nil;
local schedulemap = nil;
local playerLayer = nil;
local updateMap

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	city1 = cc.TMXTiledMap:create('city1.tmx')
	city1:align(display.CENTER, display.cx, display.cy)
    mainLayer = display.newColorLayer(cc.c4b(255, 255, 255, 255))
    mainLayer:setContentSize(display.width, display.height)
   	mainLayer:addTo(self)
   	mainLayer:addChild(city1)
    uiLayer = display.newLayer()
    uiLayer:addTo(self)
end

function MainScene:onEnter()
    local layer = city1:getLayer('ground')
    playerLayer = city1:getLayer('player')

    --加载文件
    display.addSpriteFrames("heroin.plist", "heroin.png")

    --创建动画
    local flowers = display.newAnimation
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

    --地图动画
    schedulemap = scheduler:scheduleScriptFunc(updateMap, 0.15, false)

    --添加主角
    player = Player.new()
    city1:addChild(player, table.getn(city1:getChildren()))
    player:retain()
    player:setAnchorPoint(cc.p(0,0))
    player:setPosition(layer:getTileAt(cc.p(10,10)):getPosition())
    city1:reorderChild(player, 1);

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
    scheduler:unscheduleScriptEntry(schedulemap)
end

function updateMap(dt)
    --地圖動畫
    local s = playerLayer:getLayerSize()
    for x = 0, s.width - 1, 1 do
        for y = 0, s.height - 1, 1 do        
            if playerLayer:getTileGIDAt(cc.p(x, y)) == 1 then           
                playerLayer:setTileGID(2, cc.p(x, y))
            elseif playerLayer:getTileGIDAt(cc.p(x, y)) == 2 then        
                playerLayer:setTileGID(3, cc.p(x, y))
            elseif playerLayer:getTileGIDAt(cc.p(x, y)) == 3 then          
                playerLayer:setTileGID(4, cc.p(x, y))
            elseif playerLayer:getTileGIDAt(cc.p(x, y)) == 4 then          
                playerLayer:setTileGID(5, cc.p(x, y))
            elseif playerLayer:getTileGIDAt(cc.p(x, y)) == 5 then       
                playerLayer:setTileGID(1, cc.p(x, y))
            end
        end
    end
end

return MainScene
