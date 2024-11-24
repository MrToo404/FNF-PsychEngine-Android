function onEvent(n, v1, v2)
if n == 'credits' then
makeLuaText('songStartText', '', 1280, 0, 0)
setTextBorder('songStartText', 1, '000000')
addLuaText('songStartText')
setObjectCamera('songStartText', 'other')
setTextSize('songStartText', 30)
setTextAlignment('songStartText', 'center')
updateHitbox('songStartText')
setProperty('songStartText.alpha',0)
setTextString('songStartText', v1)
screenCenter('songStartText')
setProperty('songStartText.y', getProperty('songStartText.y')+170)
setProperty('songStartText.x', getProperty('songStartText.x')+94)
start()
end
end
color = {
'FF0000',
'00FF00',
'0000FF',
'FF7F00',
'FFFF00',
'4B0082',
'9400D3'
}
function start()
doTweenColor('songStartTextColor', 'songStartText', 'FF0000', 0.2, 'quadOut')
doTweenAlpha('songStartText', 'songStartText', 1, 1, 'cubeInOut')
runTimer('byeText', 2)
end
function onTimerCompleted(tag, loops, loopsLeft)
if tag == 'byeText' then
doTweenAlpha('songStartTextBye', 'songStartText', 0, 2, 'cubeInOut')
end
end
function onTweenCompleted(tag)
if tag == 'songStartTextBye' then
removeLuaText('songStartText')
cancelTween('songStartTextColor')
end
if tag == 'songStartTextColor' then
doTweenColor('songStartTextColor', 'songStartText', color[math.random(1, 7)], 0.2, 'quadOut')
end
end