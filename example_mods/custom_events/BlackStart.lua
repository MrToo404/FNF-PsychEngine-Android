function onCreatePost()
	runHaxeCode([[
		PlayState.instance.camHUD.fade(0xFF000000, 0.001, false, true)
    ]])
end

function onEvent(eventName, value1, value2)
    if eventName == 'BlackStart' then
        runHaxeCode([[
            PlayState.instance.camHUD.fade(0xFF000000, Conductor.stepCrochet / 1000 * ]] .. value1 .. [[, true, true)
        ]])
    end
end