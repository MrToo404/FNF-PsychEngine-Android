function onCreatePost()
    setProperty('dad.alpha', 0.00001)
    noteTweenX('oppo0', 0, -1000, 1, 'quartInOut')
    noteTweenX('oppo1', 1, -1000, 1, 'quartInOut')
    noteTweenX('oppo2', 2, -1000, 1, 'quartInOut')
    noteTweenX('oppo3', 3, -1000, 1, 'quartInOut')
end

function opponentNoteHit()
    health = getProperty('health')
    if getProperty('health') > 0.1 then
        setProperty('health', health- 0.0044);
    end
end

function onStepHit()
    if curStep == 240 then
        noteTweenAlpha('bye1', 4, 0, 1, 'quartInOut')
        noteTweenAlpha('bye2', 7, 0, 1, 'quartInOut')
    end

    if curStep == 255 then
        setProperty('dad.alpha', 1)
        setProperty('boyfriend.alpha', 0.000001)
    end

    if curStep == 264 then
        noteTweenAlpha('bye3', 5, 0, 2, 'quartInOut')
        noteTweenAlpha('bye4', 6, 0, 2, 'quartInOut')
        doTweenAlpha('bye', 'camHUD', 0, 2, 'quartInOut')
    end

    if curStep == 319 then
        if getProperty('useMinecraftHealth') == true then
            for i=0,10,1 do
                setPropertyFromGroup('minecraftHealthBar', i, 'alpha', 0);
            end
            makeAnimatedLuaSprite('brokenHearts', '422-heart', getPropertyFromGroup('minecraftHealthBar', 0, 'x') - 50, getPropertyFromGroup('minecraftHealthBar', 0, 'y') - 20)
            setObjectCamera('brokenHearts', 'hud')
            addAnimationByPrefix('brokenHearts', 'idle', '422-heart idle', 30)
            scaleObject('brokenHearts', 1.5, 1.5)
            addLuaSprite('brokenHearts', true)
        end
        doTweenAlpha('hello', 'camHUD', 1, 2, 'quartInOut')
        noteTweenAlpha('bye1', 4, 1, 1, 'quartInOut')
        noteTweenAlpha('bye2', 7, 1, 1, 'quartInOut')
        noteTweenAlpha('bye3', 5, 1, 1, 'quartInOut')
        noteTweenAlpha('bye4', 6, 1, 1, 'quartInOut')
        setProperty('boyfriend.alpha', 1)
        setProperty('dad.alpha', 1)
        noteTweenX('oppo0', 0, 90, 1, 'quartInOut')
        noteTweenX('oppo1', 1, 200, 1, 'quartInOut')
        noteTweenX('oppo2', 2, 310, 1, 'quartInOut')
        noteTweenX('oppo3', 3, 420, 1, 'quartInOut')
        noteTweenAlpha('oppo4', 0, 1, 1, 'quartInOut')
        noteTweenAlpha('oppo5', 1, 1, 1, 'quartInOut')
        noteTweenAlpha('oppo6', 2, 1, 1, 'quartInOut')
        noteTweenAlpha('oppo7', 3, 1, 1, 'quartInOut')
        noteTweenX('play0', 4, 730, 1, 'quartInOut')
        noteTweenX('play1', 5, 840, 1, 'quartInOut')
        noteTweenX('play2', 6, 950, 1, 'quartInOut')
        noteTweenX('play3', 7, 1060, 1, 'quartInOut')
    end
end

function onUpdatePost()
    if curStep < 20 then
        setPropertyFromGroup('opponentStrums', 0, 'alpha', 0.000001)
        setPropertyFromGroup('opponentStrums', 1, 'alpha', 0.000001)
        setPropertyFromGroup('opponentStrums', 2, 'alpha', 0.000001)
        setPropertyFromGroup('opponentStrums', 3, 'alpha', 0.000001)
    end
end