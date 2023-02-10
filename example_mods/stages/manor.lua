function onCreate()
    luaDebugMode = true
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