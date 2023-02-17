package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import Highscore;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_menu',
		'freeplay',
		'options',
		'credits'
	];

	var charlist:Array<String> = [
		'Bscott idle dance copy0',
		'holyscott0',
		'PScott idle dance0',
		'Rex Idle0',
		'Steel Wool Idle0',
		'Team Fucked Idle0',
		'scott idle dance0',
		'yyreJ Idle0',
		"gexgex0"
	];

	var bg:FlxSprite;
	var border:FlxSprite;
	var star1:FlxSprite;
	var star2:FlxSprite;

	var char:FlxSprite;
	var floaty:Float = 0;
	var floaty2:Float = 0;

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	override function create()
	{
		FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true;

		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		bg = new FlxSprite();
		bg.loadGraphic(Paths.image('scottmenu/Checkerboard'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.scrollFactor.set(0, 0);

		border = new FlxSprite();
		border.loadGraphic(Paths.image('scottmenu/MenuOverlay'));
		border.antialiasing = ClientPrefs.globalAntialiasing;
		border.scrollFactor.set(0, 0);

		star1 = new FlxSprite(-100,-200);
		star1.loadGraphic(Paths.image('scottmenu/star1'));
		star1.antialiasing = ClientPrefs.globalAntialiasing;
		star1.alpha = 0.75;
		star1.scrollFactor.set(0, 0);

		star2 = new FlxSprite(859.85,168.75);
		star2.loadGraphic(Paths.image('scottmenu/star2'));
		star2.alpha = 0.5;
		star2.antialiasing = ClientPrefs.globalAntialiasing;
		star2.scrollFactor.set(0, 0);

		var randomchar = charlist[FlxG.random.int(0, charlist.length-1)];
		char = new FlxSprite(-620,-300);
		char.frames = Paths.getSparrowAtlas('scottmenu/char');
		char.animation.addByPrefix('idle', randomchar, 24);
		char.animation.play('idle');
		char.updateHitbox();
		char.antialiasing = false;

		switch(randomchar)
		{
			case "holyscott0":
				if(!ClientPrefs.holyclear)
					{
						char.color = 0xFF000000;
					}
			case "Bscott idle dance copy0":
				if(!ClientPrefs.bsideclear)
					{
						char.color = 0xFF000000;
					}
			case "PScott idle dance0":
				if(!ClientPrefs.pngclear)
					{
						char.color = 0xFF000000;
					}
			case "Rex Idle0":
				if(!ClientPrefs.sexclear)
					{
						char.color = 0xFF000000;
					}
			case "Steel Wool Idle0":
				if(!ClientPrefs.steelclear)
					{
						char.color = 0xFF000000;
					}
			case "Team Fucked Idle0":
				if(!ClientPrefs.fuckedclear)
					{
						char.color = 0xFF000000;
					}
			case "scott idle dance0":
				if(!ClientPrefs.storymodeclear)
					{
						char.color = 0xFF000000;
					}
			case "yyreJ Idle0":
				if(!ClientPrefs.jerryclear)
					{
						char.color = 0xFF000000;
					}
			case "gexgex0":
				if(!ClientPrefs.gexclear)
					{
						char.color = 0xFF000000;
					}
				char.setPosition(-700,-80);
		}




		add(bg);
		add(star1);
		add(star2);
		add(char);
		add(border);

		trace(star2);


		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
			{
				var menuItem:FlxSprite = new FlxSprite();
				menuItem.loadGraphic(Paths.image('scottmenu/' + optionShit[i]));
				menuItem.ID = i;
				menuItem.scrollFactor.set(0, 0);
				menuItems.add(menuItem);
				menuItem.antialiasing = ClientPrefs.globalAntialiasing;
	
				switch (i)
				{
					case 0:	// Story Mode
						menuItem.setPosition(671.4, 13.75);
					case 1:	// Freeplay
					menuItem.setPosition(859.85, 334.85);
					if(!ClientPrefs.storymodeclear)
						menuItem.color = 0xFF000000;
					case 2:	// Options
						menuItem.setPosition(529.5, 342.35);
					case 3:	// Credits
						menuItem.setPosition(608.9, 539.75);
				}
			}

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end



	var selectedSomethin:Bool = false;
	var mouseUse:Bool = false;
	var lastMousePoint:Float;
	var hoveringSomething:Bool = false;

	function checkMouseHover()
		{
			menuItems.forEach(function(spr:FlxSprite)
				{
					if (!hoveringSomething && FlxG.mouse.overlaps(spr))
					{
						hoveringSomething = true;
						if (spr.ID != curSelected)
							FlxG.sound.play(Paths.sound('scrollMenu'));
						curSelected = spr.ID;
						changeItem();
					}
					if (!FlxG.mouse.overlaps(spr) && hoveringSomething && spr.ID == curSelected)
						hoveringSomething = false;
				});
		}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		floaty += 0.01;
        floaty2 -= 0.009;
		menuItems.forEach(function(spr:FlxSprite)
			{
				spr.y -= Math.sin(floaty) * 0.02;
				spr.x -= Math.cos(floaty2) * 0.06;
			});
		star1.angle -= Math.cos(floaty) * 0.02;
		star2.angle += Math.cos(floaty) * 0.02;

	/*	trace(char.x);
		trace(char.y);

			if(FlxG.keys.justPressed.LEFT)
				char.x -= 20;

			if(FlxG.keys.justPressed.RIGHT)
				char.x += 20;
			if(FlxG.keys.justPressed.UP)
				char.y -= 20;
			if(FlxG.keys.justPressed.DOWN)
				char.y += 20;*/

		if (!selectedSomethin)
		{
			if (mouseUse)
				checkMouseHover();
	
			if (lastMousePoint != FlxG.mouse.screenX)
				{
					lastMousePoint = FlxG.mouse.screenX;
					mouseUse = true;
				}
				

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (FlxG.mouse.justPressed && hoveringSomething)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{

						}
						else
						{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_menu':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										if(!ClientPrefs.storymodeclear)
											{
												selectedSomethin = false;
												
												spr.color = 0xFF000000;
												camera.shake(0.005,0.5);
												FlxG.sound.play(Paths.sound('cancelMenu'));
											}
										else
										{
											MusicBeatState.switchState(new FreeplayState());
										}
										
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (!mouseUse)
			{
				if (curSelected >= menuItems.length-1)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = menuItems.length - 2;
			}
		else	// For the Awards
			{
				if (curSelected >= menuItems.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = menuItems.length - 2;
			}

			menuItems.forEach(function(spr:FlxSprite)
				{
					if (spr.ID == curSelected)
						{
							if(!ClientPrefs.storymodeclear && curSelected == 1)
								{
									spr.color = 0xFF000000;
								}
								
							else
								spr.color = FlxColor.WHITE;
						}
					
					else
					spr.color = FlxColor.fromHSL(spr.color.hue, spr.color.saturation, 0.4, 0.4);
				});
	}
}
