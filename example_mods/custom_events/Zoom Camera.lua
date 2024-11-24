function onEvent(eventName, value1, value2)
    if eventName == 'Zoom Camera' then
        runHaxeCode([[
           FlxTween.tween(FlxG.camera, {zoom: ]] .. value1 .. [[}, Conductor.stepCrochet / 1000 * ]] .. value2 .. [[, {ease: FlxEase.quadOut});
        ]])
    end
end