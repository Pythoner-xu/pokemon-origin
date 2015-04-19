local Map = class("Map", function ()
    return cc.TMXTiledMap:create('city1.tmx')
end)

function Map:ctor()
    display.addSpriteFrames("heroin.plist", "heroin.png")
end

return Map