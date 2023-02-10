function onCreate()
    luaDebugMode = true
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

function onUpdate()

    triggerEvent('Camera Follow Pos',600,500)

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
