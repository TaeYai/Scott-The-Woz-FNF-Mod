function onCreate()
    luaDebugMode = true
    makeLuaSprite('bg', 'rex/BC1', -400, -400);
    addLuaSprite('bg', false);

    makeLuaSprite('sky', 'rex/BC2', -400, -400);
    addLuaSprite('sky', false);

    makeLuaSprite('ground', 'rex/BC3', -400, -400);
    addLuaSprite('ground', false);

    makeAnimatedLuaSprite('Cannon','rex/Cannon',100,500)
    addAnimationByPrefix('Cannon','idle','Cannon Still0',24,false)
    addAnimationByPrefix('Cannon','shot','Canon Shot0',24,false)


    makeLuaSprite('ground2', 'rex/BC4', -400, -400);
    addLuaSprite('ground2', false);

    addLuaSprite('Cannon')

    makeLuaSprite('ground3', 'rex/BC5', -400, -400);
    addLuaSprite('ground3', false);

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
        setProperty('defaultCamZoom',0.6)
    end
end


function onBeatHit()

    if curBeat %4 == 0 then
           -- playAnim('Cannon','shot',false)
            --setProperty('Cannon.x',100)
            --setProperty('Cannon.y',-620)
    end

end
