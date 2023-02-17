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
--curBeat == 4 or curBeat == 12 or curBeat == 20 or curBeat == 28 or curBeat == 36 or curBeat == 52 or curBeat == 60 or curBeat == 68 or curBeat == 76 or curBeat == 84 or curBeat == 92 or curBeat == 100 or curBeat == 108

function onBeatHit()
    if songName == 'Chastity' then
        if curBeat %8 == 2 then
            playAnim('canon','shot')
            playAnim('canon2','shot')
        end       
    elseif songName == 'No Sex' then
        if curBeat >= 0 and curBeat <= 64 then
            if curBeat %8 == 2 then
                playAnim('canon','shot')
                playAnim('canon2','shot')
            end  
        end
        if curBeat >= 160 and curBeat <= 224 then
            if curBeat %8 == 2 then
                playAnim('canon','shot')
                playAnim('canon2','shot')
            end  
        end
        
    end


end
