function onCreate() 
    makeAnimatedLuaSprite('borders','scottroom/Borders',-2,-8)
    addAnimationByPrefix('borders','idle','Big Border0',24,false)
    addAnimationByPrefix('borders','cover','Border COver0',24,false)
    addAnimationByPrefix('borders','cover2','Border COver2',24,false)
    addAnimationByPrefix('borders','closed','Border Closed0',24,false)
    addAnimationByPrefix('borders','cut','Border Cut0',24,false)
    addAnimationByPrefix('borders','down','Border Down0',24,false)
    addAnimationByPrefix('borders','growth','Border Growth0',24,false)
    addAnimationByPrefix('borders','left','Border Left0',24,false)
    addAnimationByPrefix('borders','meta','Border Meta0',24,false)
    addAnimationByPrefix('borders','right','Border Right0',24,false)
    addAnimationByPrefix('borders','up','Border Up0',24,false)
    addLuaSprite('borders')

    setObjectCamera('borders','other')
    scaleObject('borders',0.97,0.97)

    setProperty('defaultCamZoom',0.5)
end

function onCreatePost()
    setProperty('camZooming', true)
    setProperty('camHUD.alpha',0)
end

function borderhit(num)
    if num == 1 then
        playAnim('borders','cover')
    elseif num == 2 then
        playAnim('borders','left')
    elseif num == 3 then
        playAnim('borders','right')
    elseif num == 4 then
        playAnim('borders','down')
    elseif num == 5 then
        playAnim('borders','up')
    elseif num == 6 then
        playAnim('borders','cut')
    elseif num == 7 then
        playAnim('borders','meta')
    elseif num == 8 then
        playAnim('borders','growth')
    elseif num == 9 then
        playAnim('borders','closed')
    end
end

function onBeatHit()

    if curBeat >= 172 and curBeat < 238 then
        borderhit(getRandomInt(1, 8))
    end

end


function onStepHit()

    if curStep == 13 then
        doTweenZoom('lolcam','camGame',0.7,4)
        doTweenAlpha('camHUDfade','camHUD',1,4)
    end

    if curStep == 208 then
        doTweenZoom('lolcam2','camGame',0.5,7)
    end

    if curStep == 336 then
        doTweenZoom('lolcam2','camGame',1.5,15)
    end

    if curStep == 464 or curStep == 467 or curStep == 471 or curStep == 480 or curStep == 483 or curStep == 487 or curStep == 496 or curStep == 528 or curStep == 531 or curStep == 544 or curStep == 548 or curStep == 551 or curStep == 560 or curStep == 592 or curStep == 595 or curStep == 599 or curStep == 608 or curStep == 611 or curStep == 624 or curStep == 656 or curStep == 672 then
        borderhit(getRandomInt(1, 8))
    end

    if curStep == 952 then
        borderhit(9)
    end
end