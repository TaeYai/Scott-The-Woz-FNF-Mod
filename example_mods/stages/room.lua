function onCreate()
    luaDebugMode = true
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'break');
    makeLuaSprite('bg', 'mirror/Jerry BG back', -100, -100);
    addLuaSprite('bg', false);
    makeLuaSprite('bg2', 'mirror/Jerry BG front', -100, -100);
    addLuaSprite('bg2', false);
    scaleObject('bg',1.5,1.5)
    scaleObject('bg2',1.5,1.5)


    setObjectOrder('bg',1)
    setObjectOrder('bg2',3)
    setObjectOrder('dadGroup',2)



    makeLuaSprite('border', 'scottroom/Border',0,-5)
    scaleObject('border',0.99,0.99)
    setObjectCamera('border','other')
    addLuaSprite('border',true)


    debugPrint(getProperty('camFollow.x'),getProperty('camFollow.y'))
end

function onCreatePost()

    setProperty('iconP2.alpha',0)
    setProperty('showRating',false)
    setProperty('showComboNum',false)
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    triggerEvent('Play Animation','hurt',0)
    triggerEvent('Play Animation','hurt',1)
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)

    triggerEvent('mirror',noteData,'')

end

function onUpdate()
    triggerEvent('Camera Follow Pos',600,500)
    if inGameOver then

        setProperty('camFollow.x',600);
        setProperty('camFollow.y',500);
    end
    setPropertyFromGroup('opponentStrums',0,'alpha',0)
    setPropertyFromGroup('opponentStrums',1,'alpha',0)
    setPropertyFromGroup('opponentStrums',2,'alpha',0)
    setPropertyFromGroup('opponentStrums',3,'alpha',0)
end

function onGameOverStart()
    runHaxeCode("FlxG.camera.zoom = 0.9; boyfriend.visible = false;")
    makeLuaSprite('border', 'scottroom/Border',0,-5)
    scaleObject('border',0.99,0.99)
    setObjectCamera('border','other')
    addLuaSprite('border',true)


    setProperty('boyfriend.alpha',0)
    makeLuaSprite('bg', 'mirror/Jerry BG back', -100, -100);
    addLuaSprite('bg', false);

    makeAnimatedLuaSprite('hedead2','characters/yyreJ',100,170)
    addAnimationByPrefix('hedead2','idle','yyreJ Punch0',24,false)
    addLuaSprite('hedead2')
    setObjectCamera('hedead2','game')
    playAnim('hedead2','idle',true)

    makeLuaSprite('bg2', 'mirror/Jerry BG front', -100, -100);
    addLuaSprite('bg2', false);
    scaleObject('bg',1.5,1.5)
    scaleObject('bg2',1.5,1.5)

    makeAnimatedLuaSprite('hedead','characters/Jerry',520,170)
    addAnimationByPrefix('hedead','idle','Jerry Punch0',24,false)
    addLuaSprite('hedead')
    setObjectCamera('hedead','game')
    playAnim('hedead','idle',true)


    setProperty('updateCamera',false)
    setProperty('camFollow.x',600);
    setProperty('camFollow.y',500)
    setProperty('defaultCamZoom',1)
end

function onMoveCamera(focus)
    if focus == 'boyfriend' then
        setProperty('defaultCamZoom',0.7)
        triggerEvent('Camera Follow Pos',560,500)
    end
 
    if focus == 'dad' then
        setProperty('defaultCamZoom',0.9)
    end
end


function onEvent(name, value1,value2)
	if name == "mirror" then
        cancelTimer('dadhold', 0.3, 1)
		runTimer('dadhold', 0.6, 1)

		if value1 == '0' then
			triggerEvent('Play Animation','singLEFT',0)
		end
		if value1 == '1' then
            triggerEvent('Play Animation','singDOWN',0)
		end
		if value1 == '2' then
			triggerEvent('Play Animation','singUP',0)
		end
		if value1 == '3' then
            triggerEvent('Play Animation','singRIGHT',0)
		end
	end
end
function onTimerCompleted(t,l,ll)
	if t == 'dadhold' then
        triggerEvent('Play Animation','idle',0)
	end
end
