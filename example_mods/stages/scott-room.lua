function onCreate()
    luaDebugMode = true
    makeLuaSprite('bg', 'scottroom/RoomBG', -400, -400);
    addLuaSprite('bg', false);
    scaleObject('bg',0.8,0.8)

    if songName == 'Strategy Guide' then
        makeAnimatedLuaSprite('homie','scottroom/ScottFriendsVegans',300,120)
        addAnimationByPrefix('homie','idle','Vegans0',24,false)
        addLuaSprite('homie')
    elseif songName == 'Breakout Keoni' then
        makeAnimatedLuaSprite('homie','scottroom/ScottFriends',-100,120)
        addAnimationByPrefix('homie','idle','All Friends0',24,false)
        addLuaSprite('homie')
    
    end



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

    if curBeat %1 == 0 then
        playAnim('homie','idle')
    end

end