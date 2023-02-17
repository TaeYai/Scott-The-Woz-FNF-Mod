package;

import flixel.util.FlxTimer;
#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;
import haxe.format.JsonParser;
import openfl.display.BitmapData;
import flash.geom.Rectangle;
import flixel.ui.FlxButton;
import flixel.FlxBasic;
import sys.io.File;

using StringTools;

class UnlockState extends MusicBeatState
{

    var placeTxt:FlxText;
    var bg:FlxSprite;
    var colorTween:FlxTween;
    var needaReset = false;
    var canExit:Bool = false;
    override function create()
        {
            ClientPrefs.sexclear  = true;
			ClientPrefs.saveSettings();
			FlxG.save.flush();


            FlxG.sound.play(Paths.sound('unlocksound'));  
            bg = new FlxSprite().loadGraphic(Paths.image('scottmenu/BonusUnlock'));
            bg.antialiasing = false;
            bg.setGraphicSize(1280,720);
            add(bg);
            bg.screenCenter();
        
            placeTxt = new FlxText(0, 670, FlxG.width, "Press Enter To Continue", 48);
            placeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            placeTxt.scrollFactor.set();
            placeTxt.borderSize = 2;
            add(placeTxt);
            placeTxt.screenCenter(X);

            new FlxTimer().start(3, function(tmr:FlxTimer) {
                canExit = true;
            });
    }


    override function update(elapsed:Float)
        {
            if(controls.ACCEPT)
                {
                    if(canExit)
                        {
                            if(needaReset)
                                {
                                    //MusicBeatState.switchState(new TitleState());
                                    TitleState.initialized = false;
                                    TitleState.closedState = false;
                                    FlxG.sound.music.fadeOut(0.3);
                                    if(FreeplayState.vocals != null)
                                    {
                                        FreeplayState.vocals.fadeOut(0.3);
                                        FreeplayState.vocals = null;
                                    }
                                    FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
                                }
                                else
                                {
                                    FlxG.sound.playMusic(Paths.music('freakyMenu'));
                                    MusicBeatState.switchState(new MainMenuState());
                                }
                        }

                }
         }
}