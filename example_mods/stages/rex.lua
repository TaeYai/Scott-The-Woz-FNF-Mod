function onCreate()

    luaDebugMode = true


    makeLuaSprite('border', 'scottroom/Border',0,-5)
    scaleObject('border',0.99,0.99)
    setObjectCamera('border','other')
    addLuaSprite('border',true)

    makeAnimatedLuaSprite('box','rex/box',0,-2200)
    addAnimationByPrefix('box','idle','Tween 8',24,true) 
    addLuaSprite('box')
    playAnim('box','idle')

    setObjectOrder('box',2)


end

function onCreatePost()
    setProperty('canon.y',-640)
    setProperty('canon2.y',-540)
    debugPrint(getProperty('canon2.x'))
end


function onMoveCamera(focus)
    if focus == 'boyfriend' then
        setProperty('defaultCamZoom',0.9)
    end
 
    if focus == 'dad' then
        setProperty('defaultCamZoom',0.6)
    end
end

function onUpdate(elapsed)
    setProperty('box.y', getProperty('box.y') + 250 * elapsed)
    if(getProperty('box.y') >= 1200) then
        setProperty('box.y',-4200)
    end

  --  runHaxeCode([[game.getLuaObject("box").y += 250; 
  --  if (getLuaObject("box").y > 1500) getLuaObject("box").y = 0;]])
end


function onBeatHit()

    if curBeat %7 == 2 then
        playAnim('canon','shot')
        playAnim('canon2','shot')
    end

end
