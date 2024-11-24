function onCreate()

	makeLuaSprite('you', 'yourNotesMC', 680, 125);
	setScrollFactor('you', 0, 0);
    setObjectCamera('you', 'hud')
    scaleObject('you', 0.8, 0.8);
    setProperty('you.alpha', 0.65);
	setObjectOrder('you', getObjectOrder('strumLineNotes') - 1)
	addLuaSprite('you', true);

    leftkey1 = getNoteKey(0, false, 3)
    leftkey2 = getNoteKey(0, true, 3)
    downkey1 = getNoteKey(1, false, 3)
    downkey2 = getNoteKey(1, true, 3)
    upkey1 = getNoteKey(2, false, 3)
    upkey2 = getNoteKey(2, true, 3)
    rightkey1 = getNoteKey(3, false, 3)
    rightkey2 = getNoteKey(3, true, 3)
end

function onCreatePost()
    setNoteKey(0, leftkey1, leftkey2)
    setNoteKey(1, downkey1, downkey2)
    setNoteKey(2, upkey1, upkey2)
    setNoteKey(3, rightkey1, rightkey2)
    setNoteKey(4, 'NONE', 'NONE')
    setNoteKey(5, 'NONE', 'NONE')
    setNoteKey(6, 'NONE', 'NONE')
    setNoteKey(7, 'NONE', 'NONE')
    
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Autoplayed' then
            setPropertyFromGroup('unspawnNotes', i, 'autoPlayed', true);
        end
    end
end

function onEvent(n, v1, v2)
    if n == 'changePlayedCharacter' and v1 == '2' then
		doTweenX('youIndicator', 'you', 960, 0.2, 'linear');
        setNoteKey(0, 'NONE', 'NONE')
        setNoteKey(1, 'NONE', 'NONE')
        setNoteKey(2, 'NONE', 'NONE')
        setNoteKey(3, 'NONE', 'NONE')
        setNoteKey(4, leftkey1, leftkey2)
        setNoteKey(5, downkey1, downkey2)
        setNoteKey(6, upkey1, upkey2)
        setNoteKey(7, rightkey1, rightkey2)
    else
        if n == 'changePlayedCharacter' then
            doTweenX('youIndicator', 'you', 680, 0.2);
            setNoteKey(0, leftkey1, leftkey2)
            setNoteKey(1, downkey1, downkey2)
            setNoteKey(2, upkey1, upkey2)
            setNoteKey(3, rightkey1, rightkey2)
            setNoteKey(4, 'NONE', 'NONE')
            setNoteKey(5, 'NONE', 'NONE')
            setNoteKey(6, 'NONE', 'NONE')
            setNoteKey(7, 'NONE', 'NONE')
        end
    end
end