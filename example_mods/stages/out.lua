function onCreate()
	makeLuaSprite('bg', 'OBG/sky', -1204, -456);
	makeLuaSprite('clouds', 'OBG/clouds', -988, -260);
	makeLuaSprite('backmount', 'OBG/backmount', -700, -40);
	makeLuaSprite('middlemount', 'OBG/middlemount', -240, 200);
	makeLuaSprite('ground', 'OBG/ground', -660, 624);

	setScrollFactor('bg', 0.15, 0.15);
	setScrollFactor('clouds', 0.25, 0.25);
	setScrollFactor('backmount', 0.4, 0.4);
	setScrollFactor('middlemount', 0.6, 0.6);

	addLuaSprite('bg', false);
	addLuaSprite('clouds', false);
	addLuaSprite('backmount', false);
	addLuaSprite('middlemount', false);
	addLuaSprite('ground', false);
	
	makeLuaSprite('bgdim', nil, 0, 0);
	makeGraphic('bgdim', 4000, 4000, '000000');
	screenCenter('bgdim', 'xy');
	setObjectCamera('bgdim', 'camhud');
	setProperty('bgdim.alpha', 0);
	setProperty('bgdim.visible', false); -- only thunderstorm uses it
	addLuaSprite('bgdim', true);
	setObjectOrder('bgdim', getObjectOrder('boyfriend') + 1)
end

local bgDim = false;
local rotCam = false;
local rotCamInd = 0;
local rotCamSpd = 1;
local rotCamRange = 10;
function onUpdate()
	if rotCam then
		rotCamInd = rotCamInd + 1;
		setProperty('camera.angle', math.sin(rotCamInd / 100 * rotCamSpd) * rotCamRange);
	else
		rotCamInd = 0;
	end
	
	if bgDim then
		if getProperty('bgdim.alpha') < 0.5 then
			setProperty('bgdim.alpha', getProperty('bgdim.alpha') + 0.01);
		end
	else
		if getProperty('bgdim.alpha') > 0 then
			setProperty('bgdim.alpha', getProperty('bgdim.alpha') - 0.01);
		end
	end

end

function onStepHit() -- events
		if curStep == 1088 then
			setProperty('bgdim.visible', true);
			bgDim = true;
		end
		if curStep == 1152 then
			bgDim = false;
		end
		if curStep == 1216 then
			bgDim = true;
		end
		if curStep == 1280 then
			bgDim = false;
		end
end
function camRotate(on, spd, range)
	if on then
		rotCam = true;
		rotCamSpd = spd;
		rotCamRange = range;
	else
		rotCam = false;
		setProperty('camera.angle', 0);
	end
end