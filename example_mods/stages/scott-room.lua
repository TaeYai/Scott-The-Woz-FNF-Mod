function onCreate()
    luaDebugMode = true
    if songName == 'Team Fucked' then
        makeLuaSprite('bg', 'fucked/FuckedBG', -100, -200);
        addLuaSprite('bg', false);
    else
        makeLuaSprite('bg', 'scottroom/RoomBG', -400, -400);
        addLuaSprite('bg', false);
        scaleObject('bg',0.8,0.8)
    end

    if songName == 'Strategy Guide' or songName == 'Why Dont You Play Them' then
        makeAnimatedLuaSprite('homie','scottroom/ScottFriendsVegans',300,120)
        addAnimationByPrefix('homie','idle','Vegans0',24,false)
        addLuaSprite('homie')
    elseif songName == 'Breakout Keoni' or songName == 'Breakout' then
        makeAnimatedLuaSprite('homie','scottroom/ScottFriends',-100,120)
        addAnimationByPrefix('homie','idle','All Friends0',24,false)
        addLuaSprite('homie')
    elseif songName == 'Borderless' then
        makeAnimatedLuaSprite('homie','scottroom/ScottFriends',-100,120)
        addAnimationByPrefix('homie','idle','All Friends0',24,false)
        addLuaSprite('homie')
    elseif songName == 'Team Fucked' then
        makeAnimatedLuaSprite('homie','fucked/ScottFriends(Fucked)',1500,120)
        addAnimationByPrefix('homie','idle','All Friends0',24,false)
        addLuaSprite('homie')
    elseif songName == 'Dark Age' then
        makeAnimatedLuaSprite('homie','darkage/ScottFriendsGex',-100,120)
        addAnimationByPrefix('homie','idle','All Friends0',24,false)
        addLuaSprite('homie')
    elseif songName == 'Breakout Borderline Mix' then
        makeAnimatedLuaSprite('homie','breakout/ScottCrowd',-100,-120)
        addAnimationByPrefix('homie','idle','Bg Characters0',24,false)
        addAnimationByPrefix('homie','slide','Bg Characters Slide0',24,false)
        addLuaSprite('homie')
        setProperty('homie.alpha',0)
    end

    if dadName == 'gex' then
        setProperty('dadGroup.x',200)
        setProperty('dadGroup.y',320)
        setProperty('opponentCameraOffset[1]', -100)
    end

    if boyfriendName == 'scott-player' then
        setProperty('boyfriendCameraOffset[0]', -130)
    end

    if dadName == 'target' then
        setProperty('dadGroup.x',100)
        setProperty('dadGroup.y',370)


        setProperty('opponentCameraOffset[1]', -20)
        setProperty('opponentCameraOffset[0]', 500)
    end



    makeLuaSprite('border', 'scottroom/Border',0,-5)
    scaleObject('border',0.99,0.99)
    setObjectCamera('border','other')
    addLuaSprite('border',true)



end

function onCreatePost()
    if songName == 'Team Fucked' then
        setProperty('dad2.x',200)
        setProperty('dad2.y',340)

        setProperty('dad3.x',500)
        setProperty('dad3.y',290)

        setObjectOrder('gfGroup',1)

        setObjectOrder('dad3',2)
        setObjectOrder('dadGroup',4)
        setObjectOrder('dad2',3)
    end
end


function onMoveCamera(focus)
    if focus == 'boyfriend' then
        if boyfriendName == 'scott-player' then
            setProperty('defaultCamZoom',0.7)

        else
        setProperty('defaultCamZoom',0.9)
        end
    end
 
    if focus == 'dad' then
        if dadName == 'gex' then
            setProperty('defaultCamZoom',0.9)
        else
        setProperty('defaultCamZoom',0.7)
        end
    end
end


function onBeatHit()

    if curBeat %1 == 0 then
        playAnim('homie','idle')
    end

end

function onStepHit()

    if songName == 'Breakout Borderline Mix' then
        if curStep == 703 then
            setProperty('homie.alpha',1)
            playAnim('homie','slide')
        end
    end

end