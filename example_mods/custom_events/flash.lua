function onEvent(name,value1,value2)

    if name == "flash" and flashingLights == true then
        cameraFlash('game','FFFFFF',value2,true)
	end
end