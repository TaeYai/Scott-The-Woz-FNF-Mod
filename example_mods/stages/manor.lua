function onCreate()
    setPropertyFromClass('GameOverSubstate', 'characterName', 'scott-dead');
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'gameoverscott');
    makeLuaSprite('bg', 'manor/ManorBG', -100, -100);
    addLuaSprite('bg', false);

    makeAnimatedLuaSprite('hedead','manor/DeadBF',getCharacterX('boyfriend') +200,getCharacterY('boyfriend') + 620)
    addAnimationByPrefix('hedead','idle','Dead Bf0',24,false)
    addLuaSprite('hedead')
    

    setObjectOrder('gfGroup',1)
    setObjectOrder('boyfriendGroup',2)
    setObjectOrder('hedead',3)


    makeLuaSprite('border', 'scottroom/Border',0,-5)
    scaleObject('border',0.99,0.99)
    setObjectCamera('border','other')
    addLuaSprite('border',true)



end

function onGameOverStart()
    runHaxeCode("FlxG.camera.zoom = 1.2;")
    setProperty('boyfriend.alpha',0)
    makeLuaSprite('bg', 'manor/ManorBG', -100, -100);
    addLuaSprite('bg', false);
    makeLuaSprite('slideborder', 'empty', 1400, 10)
	makeGraphic('slideborder', 1280, 720, '324bf4')

    makeAnimatedLuaSprite('hedead','characters/dead-scott',-160,-500)
    setProperty('hedead.flipX',true)
    addAnimationByPrefix('hedead','idle','Scott Dies0',24,false)
    addLuaSprite('hedead')
    setObjectCamera('hedead','game')
    playAnim('hedead','idle',true)

	setObjectCamera('slideborder', 'game')
	addLuaSprite('slideborder', false)
    setProperty('updateCamera',false)

    setProperty('camFollowPos.x',1170);
    setProperty('camFollowPos.y',300)
    setProperty('defaultCamZoom',1)
end


function onUpdate(elapsed)
    if health == 0 then
        triggerEvent('Camera Follow Pos',1170,300)
    end
    if inGameOver then
        setProperty('updateCamera',false)

        setProperty('camFollowPos.x',1170);
        setProperty('camFollowPos.y',300)
    end
end
    


function onMoveCamera(focus)
    if focus == 'boyfriend' then
        setProperty('defaultCamZoom',0.9)
    end
 
    if focus == 'dad' then
        setProperty('defaultCamZoom',0.7)
    end
end


function onBeatHit()

    if curBeat %2 == 0 then
        playAnim('hedead','idle')
    end

end