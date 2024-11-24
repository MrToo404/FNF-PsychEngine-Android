--Create with TieGuo's Lua Stage Editor
function onCreate()
makeAnimatedLuaSprite('desertButAnime', '422/422-cut', -1240, -660)
addLuaSprite('desertButAnime', true)
addAnimationByPrefix('desertButAnime', '422cut', '422-cut idle', 24, false)
scaleObject('desertButAnime', 5.9, 5.9)
setScrollFactor('desertButAnime', 1, 1)
end

function onCreate()
makeLuaSprite('desert', '422/Empty_desert', -1240, -660)
addLuaSprite('desert', false)
scaleObject('desert', 5.9, 5.9)
setScrollFactor('desert', 1, 1)
end