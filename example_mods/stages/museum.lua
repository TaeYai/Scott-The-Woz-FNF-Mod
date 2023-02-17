function onCreate()
    luaDebugMode = true
    setPropertyFromClass('GameOverSubstate', 'characterName', 'holydad');
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'dadgameover');
    
    makeLuaSprite('bg', 'museum/Museum', -400, -400);
    addLuaSprite('bg', false);

    makeAnimatedLuaSprite('boy','museum/BoyBop',240,-220)
    addAnimationByPrefix('boy','idle','Boy Bop0',24,false)
    addLuaSprite('boy')
    
    makeAnimatedLuaSprite('girl','museum/GirlBop',60,-140)
    addAnimationByPrefix('girl','idle','Girl Bop00',24,false)
    addLuaSprite('girl')

    makeAnimatedLuaSprite('cave','museum/CaveBop',200,-330)
    addAnimationByPrefix('cave','idle','Caveman Bop0',24,false)
    addLuaSprite('cave')

    setObjectOrder('cave',1)
    setObjectOrder('boyfriendGroup',2)

    makeLuaSprite('border', 'scottroom/Border',0,-5)
    scaleObject('border',0.99,0.99)
    setObjectCamera('border','other')
    addLuaSprite('border',true)



end

function onMoveCamera(focus)
    if focus == 'boyfriend' then
        setProperty('defaultCamZoom',2.5)
    end
 
    if focus == 'dad' then
        setProperty('defaultCamZoom',2)
    end
end


function onBeatHit()

    if curBeat %2 == 0 then
        playAnim('girl','idle')
    end

    if curBeat %1 == 0 then
        playAnim('boy','idle')
        playAnim('cave','idle')
    end

end