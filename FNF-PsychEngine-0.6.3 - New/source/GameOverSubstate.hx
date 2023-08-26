package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flash.text.TextField;
import PlayState.curStage;

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend;
	var camFollow:FlxPoint;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";
	var TerminationText:FlxSprite;
	var killedByGAMEOVER:String = "idfk";
	var killedByTextDisplay:FlxText;
	var textGenerated:Bool = false;

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	public static var instance:GameOverSubstate;

	public static function resetVariables() {
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);
        textGenerated = false;
		super.create();
	}

    var kysnow:FlxSprite;
	var curstage:String = PlayState.curStage;

    public function new(killedBy:String, x:Float, y:Float, camX:Float, camY:Float)
    {
        super();

        kysnow = new FlxSprite();
        kysnow.loadGraphic("assets/images/kysnow.png");
        add(kysnow);

        kysnow.alpha = 0.5;

        PlayState.instance.setOnLuas('inGameOver', true);

        Conductor.songPosition = 0;

        boyfriend = new Boyfriend(x, y, characterName);
        boyfriend.x += boyfriend.positionArray[0];
        boyfriend.y += boyfriend.positionArray[1];
        add(boyfriend);

        killedByGAMEOVER=killedBy;

        if(killedByGAMEOVER=="sawblade"){
        // Sawblade death
        TerminationText = new FlxSprite();
        TerminationText.frames = Paths.getSparrowAtlas('hazard/sawkillanimation2');
        TerminationText.animation.addByPrefix('normal', 'kb_attack_animation_kill_idle', 24, true);
        TerminationText.animation.addByPrefix('animate', 'kb_attack_animation_kill_moving', 24, true);
        TerminationText.x = x-1175; //negative = left
        TerminationText.y = y+500; //positive = down
        TerminationText.antialiasing = ClientPrefs.globalAntialiasing;
        TerminationText.animation.play("normal");
        add(TerminationText);
	    }

        if (curstage != "stage2")
        {
            camFollow = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
        }

        else {
            camFollow = new FlxPoint(kysnow.getGraphicMidpoint().x, kysnow.getGraphicMidpoint().y);
        }

        FlxG.sound.play(Paths.sound(deathSoundName));
        Conductor.changeBPM(100);
        // FlxG.camera.followLerp = 1;
        // FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
        FlxG.camera.scroll.set();
        FlxG.camera.target = null;

        boyfriend.playAnim('firstDeath');

        camFollowPos = new FlxObject(0, 0, 1, 1);
        camFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2));
        add(camFollowPos);
    }

	var isFollowingAlready:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		boyfriend.playAnim('idle', true);

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
		if(updateCamera) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 0.6, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		}

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			WeekData.loadTheFirstEnabledMod();
			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		if (boyfriend.animation.curAnim != null && boyfriend.animation.curAnim.name == 'firstDeath')
		{
			if(boyfriend.animation.curAnim.curFrame >= 12 && !isFollowingAlready)
			{
				FlxG.camera.follow(camFollowPos, LOCKON, 1);
				updateCamera = true;
				isFollowingAlready = true;
			}

			if (boyfriend.animation.curAnim.finished && !playingDeathSound)
			{
				if (PlayState.SONG.stage == 'tank')
				{
					playingDeathSound = true;
					coolStartDeath(0.2);
					
					var exclude:Array<Int> = [];
					//if(!ClientPrefs.cursing) exclude = [1, 3, 8, 13, 17, 21];

					FlxG.sound.play(Paths.sound('jeffGameover/jeffGameover-' + FlxG.random.int(1, 25, exclude)), 1, false, null, true, function() {
						if(!isEnding)
						{
							FlxG.sound.music.fadeIn(0.2, 1, 4);
						}
					});
				}

                if (PlayState.SONG.stage == 'stage2')
				{
					playingDeathSound = true;
					coolStartDeath();
					
					var exclude:Array<Int> = [];
					//if(!ClientPrefs.cursing) exclude = [1, 3, 8, 13, 17, 21];

					FlxG.sound.play(Paths.sound('jeffGameover/jeffGameover-' + FlxG.random.int(1, 25, exclude)), 1, false, null, true, function() {
						if(!isEnding)
						{
							FlxG.sound.music.fadeIn(0.2, 1, 4);
						}
					});
				}
				else
				{
					coolStartDeath();
				}
				boyfriend.startedDeath = true;
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);

		if(killedByGAMEOVER=="sawblade"){
			TerminationText.animation.play("animate");
		}

		FlxTween.tween(FlxG.camera, {zoom: 0.86}, 2.2, {ease:FlxEase.quadInOut}); //To ensure you can read the death text.
		displayDeathText(false);
	}

	function displayDeathText(instantAppear:Bool = false):Void
	{
		if(!textGenerated)
		{
		switch(killedByGAMEOVER)
		{
			case "sawblade":
			var dodgeKey:String = InputFormatter.getKeyName(ClientPrefs.keyBinds.get('dodge')[0]);
			if (dodgeKey == "---"){
			dodgeKey = InputFormatter.getKeyName(ClientPrefs.keyBinds.get('dodge')[1]);
			}
			
			killedByTextDisplay = new FlxText(boyfriend.x - 535, boyfriend.y - 305, 0, ("Ouch, That looks painful!\n(Press (" + dodgeKey + ") To Dodge!)"), 28);
			killedByTextDisplay.setFormat(Paths.font("vcr.ttf"), 28, FlxColor.WHITE, CENTER);
			textGenerated = true;
	
			case "hurt":
			killedByTextDisplay = new FlxText(boyfriend.x - 535, boyfriend.y - 290, 0, "Died to a hurt note. (Health)", 32);
			killedByTextDisplay.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
			textGenerated = true;
	
			case "reset":
			killedByTextDisplay = new FlxText(boyfriend.x - 535, boyfriend.y - 290, 0, "Reset button pressed.", 32);
			killedByTextDisplay.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
			textGenerated = true;
	
			default:
			killedByTextDisplay = new FlxText(boyfriend.x - 535, boyfriend.y - 290, 0, "Died to missing a note. (Health)", 32);
			killedByTextDisplay.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
			textGenerated = true;
			}
		}
	
		if (!instantAppear)
		{
			killedByTextDisplay.alpha = 0;
			add(killedByTextDisplay);
			FlxTween.tween(killedByTextDisplay, {alpha: 1}, 1, {ease: FlxEase.sineOut});
		}
		else
		{
		add(killedByTextDisplay);
		}
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			displayDeathText(true);
			boyfriend.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			FlxG.camera.zoom = FlxG.camera.zoom += 1;
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
