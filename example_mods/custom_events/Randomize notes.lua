function onSongStart()
    a = 350  -- min x
    b = 450  -- max x
    c = 0    -- forgor
    d = 300  -- min y
    e = 350  -- max y
    if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
       d = 350
       e = 450
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'Randomize notes' then
        if value1 == 'on' then
            random()
            noteTweenX('Notemove1', 4, number, 0.1, 'cubeInOut')
            random()
            noteTweenX('Notemove2', 5, number, 0.1, 'cubeInOut')
            random()
            noteTweenX('Notemove3', 6, number, 0.1, 'cubeInOut')
            random()
            noteTweenX('Notemove4', 7, number, 0.1, 'cubeInOut')
            random()
            noteTweenY('Notemove5', 4, number2, 0.1, 'cubeInOut')
            random()
            noteTweenY('Notemove6', 5, number2, 0.1, 'cubeInOut')
            random()
            noteTweenY('Notemove7', 6, number2, 0.1, 'cubeInOut')
            random()
            noteTweenY('Notemove8', 7, number2, 0.1, 'cubeInOut')

            noteTweenX('oppo0', 0, -1000, 1, 'quartInOut')
            noteTweenX('oppo1', 1, -1000, 1, 'quartInOut')
            noteTweenX('oppo2', 2, -1000, 1, 'quartInOut')
            noteTweenX('oppo3', 3, -1000, 1, 'quartInOut')
        else
            if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
                noteTweenY('Notemovebac1', 4, 50, 0.2, 'cubeInOut')
                noteTweenY('Notemovebac2', 5, 50, 0.2, 'cubeInOut')
                noteTweenY('Notemovebac3', 6, 50, 0.2, 'cubeInOut')
                noteTweenY('Notemovebac4', 7, 50, 0.2, 'cubeInOut')
            else
                noteTweenY('Notemovebac1', 4, 570, 0.2, 'cubeInOut')
                noteTweenY('Notemovebac2', 5, 570, 0.2, 'cubeInOut')
                noteTweenY('Notemovebac3', 6, 570, 0.2, 'cubeInOut')
                noteTweenY('Notemovebac4', 7, 570, 0.2, 'cubeInOut')
            end
            noteTweenX('play0', 4, 730, 1, 'quartInOut')
            noteTweenX('play1', 5, 840, 1, 'quartInOut')
            noteTweenX('play2', 6, 950, 1, 'quartInOut')
            noteTweenX('play3', 7, 1060, 1, 'quartInOut')
            noteTweenX('oppo0', 0, 90, 1, 'quartInOut')
            noteTweenX('oppo1', 1, 200, 1, 'quartInOut')
            noteTweenX('oppo2', 2, 310, 1, 'quartInOut')
            noteTweenX('oppo3', 3, 420, 1, 'quartInOut')
        end
    end
end

function random()
    math.randomseed(os.clock())
    math.random()
    number = math.random(a, b)
    number2 = math.random(d, e)
    a = a + 200
    b = b + 200
    c = c + 1
    d = d + 1
    e = e + 1
    debugPrint(n)
    if c == 4 then
       a = 300
       b = 400
       c = 0
       e = 150
       d = 250
       if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
          d = 350
          e = 450
       end
    end
end