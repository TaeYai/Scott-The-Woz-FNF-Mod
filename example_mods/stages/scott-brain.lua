function onCreate()
    makeAnimatedLuaSprite('bg','scottroom/RemasteredBrainBG',-400, -600)
    addAnimationByPrefix('bg','idle','Brain Animation AltAlt nofloor instance 1',24,false)
    addLuaSprite('bg')
    scaleObject('bg',1.7,1.7)

    makeLuaSprite('floor', 'scottroom/Floorbrain', -400, -500);
    addLuaSprite('floor', false);


    makeLuaSprite('border', 'scottroom/Big Border',-2,-8)
    scaleObject('border',0.97,0.97)
    setObjectCamera('border','other')
    --addLuaSprite('border',true)



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

    if curBeat %1 == 0 then
        playAnim('bg','idle')
    end

end