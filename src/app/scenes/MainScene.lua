
local wakeUpLate = false;
local mainLayer = nil;
local uiLayer = nil;
local chooseButton = {};
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	chooseButton.RADIO_BUTTON_IMAGES = {
		on = "choose.png"
	}
	
	local tmx = ccexp.TMXTiledMap:create('city1.tmx')
	tmx:align(display.CENTER, display.cx, display.cy)
    
    mainLayer = display.newColorLayer(cc.c4b(255, 255, 255, 255))
    mainLayer:setContentSize(display.width, display.height)
   	mainLayer:addTo(self)
    uiLayer = display.newLayer()
    uiLayer:setContentSize(display.width, display.height)
    uiLayer:addTo(self)
    cc.ui.UILabel.new({
            UILabelType = 2, text = "叮铃铃，叮铃铃（闹钟响了）", size = 64, color = display.COLOR_BLACK})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
    local chooseGroup = cc.ui.UICheckBoxButtonGroup.new(display.TOP_TO_BOTTOM)
    chooseGroup:addButton(cc.ui.UICheckBoxButton.new(chooseButton.RADIO_BUTTON_IMAGES)
    		:setButtonLabel(cc.ui.UILabel.new({text = "继续睡", color = display.COLOR_BLACK}))
    		:setButtonLabelOffset(20, 0)
    		:align(display.LEFT_CENTER))
    chooseGroup:addButton(cc.ui.UICheckBoxButton.new(chooseButton.RADIO_BUTTON_IMAGES)
    		:setButtonLabel(cc.ui.UILabel.new({text = "继续睡", color = display.COLOR_BLACK}))
    		:setButtonLabelOffset(20, 0)
    		:align(display.LEFT_CENTER))
    chooseGroup:setButtonsLayoutMargin(10,10)
    chooseGroup:onButtonSelectChanged(function(event)
    		printf("Option %d selected, Option %d unseleceted", event.selected, event.last)
    	end)
    chooseGroup:align(display.CENTER, display.cx, display.cy)
    chooseGroup:addTo(self)
    tmx:addTo(mainLayer)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
