local frame = 150 -- write 1/3 the width of your icon image
local eksi = 0
function onCreatePost()
        makeLuaSprite('sical','',99999,99999)
	setProperty('sical.scale.x',0.00001)
	addLuaSprite('sical', true);

mal = getProperty('iconP1.animation.name')
mal2 = getProperty('iconP2.animation.name')

	makeAnimatedLuaSprite('simge1',nil, getProperty('iconP1.x'), getProperty('iconP1.y')+getProperty('sical.scale.x'))
	loadGraphic('simge1','icons/icon-'..mal, frame)
	addAnimation('simge1','icons/icon-'..mal, {0, 1, 2}, 0, true)
	setObjectCamera('simge1', 'hud')
	setObjectOrder('simge1', getObjectOrder('iconP1') + 1)

	addLuaSprite('simge1', true)

	makeAnimatedLuaSprite('simge2',nil, getProperty('iconP2.x'), getProperty('iconP2.y')+getProperty('sical.scale.x'))
	loadGraphic('simge2','icons/icon-'..mal2, frame)
	addAnimation('simge2','icons/icon-'..mal2, {0, 1, 2}, 0, true)
	setObjectCamera('simge2', 'hud')
	setObjectOrder('simge2', getObjectOrder('iconP2') + 1)

	addLuaSprite('simge2', true)

end
function onEvent(n)
if n == 'Change Character' then
mal = getProperty('iconP1.animation.name')
mal2 = getProperty('iconP2.animation.name')

	makeAnimatedLuaSprite('simge1',nil, getProperty('iconP1.x'), getProperty('iconP1.y')+getProperty('sical.scale.x'))
	loadGraphic('simge1','icons/icon-'..mal, frame)
	addAnimation('simge1','icons/icon-'..mal, {0, 1, 2}, 0, true)
	setObjectCamera('simge1', 'hud')
	setObjectOrder('simge1', getObjectOrder('iconP1') + 1)

	addLuaSprite('simge1', true)

	makeAnimatedLuaSprite('simge2',nil, getProperty('iconP2.x'), getProperty('iconP2.y')+getProperty('sical.scale.x'))
	loadGraphic('simge2','icons/icon-'..mal2, frame)
	addAnimation('simge2','icons/icon-'..mal2, {0, 1, 2}, 0, true)
	setObjectCamera('simge2', 'hud')
	setObjectOrder('simge2', getObjectOrder('iconP2') + 1)

	addLuaSprite('simge2', true)
end
end
function onUpdate()
	setObjectCamera('simge2', 'hud')
	setObjectCamera('simge1', 'hud')
	setObjectOrder('simge1', getObjectOrder('iconP1') + 1)
	setObjectOrder('simge2', getObjectOrder('iconP2') + 1)
	setProperty('simge1.x', getProperty('iconP1.x'))
	setProperty('simge2.x', getProperty('iconP2.x'))
	setProperty('simge1.y', getProperty('iconP1.y'))
	setProperty('simge2.y', getProperty('iconP2.y'))
	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	setProperty('simge1.angle', getProperty('iconP1.angle'))
	setProperty('simge1.scale.x', getProperty('iconP1.scale.x'))
	setProperty('simge1.scale.y', getProperty('iconP1.scale.y'))
	setProperty('simge1.flipX', true)
	setProperty('simge2.angle', getProperty('iconP2.angle'))
	setProperty('simge2.scale.x', getProperty('iconP2.scale.x'))
	setProperty('simge2.scale.y', getProperty('iconP2.scale.y'))

        if eksi == -1 then
eksi = 0
end
	if getProperty('health') > 1.6 then
		setProperty('simge2.animation.curAnim.curFrame', '1')
		setProperty('simge1.animation.curAnim.curFrame', '2')
end
	if getProperty('health') < 1.6 and getProperty('health') > 0.4 then
		setProperty('simge2.animation.curAnim.curFrame', '0')
		setProperty('simge1.animation.curAnim.curFrame', '0')
end
	if getProperty('health') < 0.4 then
		setProperty('simge1.animation.curAnim.curFrame', '1')
		setProperty('simge2.animation.curAnim.curFrame', '2')
end
end
function onBeatHit()
	setProperty('sical.scale.x', getProperty('iconP1.height')/10)
        doTweenX('sicalll', 'sical.scale', 0, 0.35, 'circOUT')
end
