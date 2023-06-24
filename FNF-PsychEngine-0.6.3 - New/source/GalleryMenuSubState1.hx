package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.addons.ui.FlxUIState;
import Global;
import Controls;

// import openfl.Assets;
// import flash.display.Sprite;
// import gif.AnimatedGif;
// import haxe.io.Bytes;
class GalleryMenuSubState1 extends FlxState
{
	public static var curSelected:Int = 0;

	private var controls(get, never):Controls;
	var imageShit:Array<String> = [
		'image0',
		'image1',
		'image2',
		'image3',
		// 'image5'
	];
	var menuItems:FlxTypedGroup<FlxSprite>;
	var camFollow:FlxObject;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	override public function create():Void
	{
		var gallerybg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('galleryBG'));
		add(gallerybg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		// var bytes:Bytes = Bytes.ofString(Assets.getText("assets/images/gallery/testing.gif"));
		// var gif1 = new AnimatedGif(bytes);
		// this.add(gif1);
		// gif1.y = 500;
		// gif1.x = 300;
		// gif1.play();
		// gif1.rotation = 32;

		// bytes = haxe.io.Bytes.ofString(Assets.getText("assets/images/gallery/testing.gif"));
		// this.add(new AnimatedGif(bytes).play());

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 0.5;

		for (i in 0...imageShit.length)
		{
			var offset:Float = 108 - (Math.max(imageShit.length, 6) - 6) * 80;
			var menuItem:FlxSprite = new FlxSprite((i * 140), 0);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.loadGraphic('assets/images/gallery/' + imageShit[i] + '.png');
		    //menuItem.x += -40; // adjust x coordinate based on index i
			menuItem.ID = i;
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			// 0.135 is original value
			var scr:Float = (imageShit.length - 6) * 0.27;
			scr = 0;
			menuItem.scrollFactor.set(0, 0);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			// menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		changeItem();

		var selectedSomethin:Bool = false;

		// var galleryimage1:FlxSprite = new FlxSprite(400, 300).loadGraphic(('assets/images/gallery/image2.png'));
		// add(galleryimage1);

		// Create a title text
		var titleText:FlxText = new FlxText(450, 20, FlxG.width, "Scrapped Art");
		titleText.setFormat(null, 50, 0xffffff);
		titleText.setBorderStyle(OUTLINE, FlxColor.BLACK, 2);
		add(titleText);

		// Back Button
		var backBtn:FlxButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height * 2 / 3, "", waitfuckgoback);
		add(backBtn);
		backBtn.loadGraphic(Paths.image("backbutton"));
		backBtn.scrollFactor.set(0, 0); // Make the button not scroll with the camera

		backBtn.x = 25;
		backBtn.y = 50;

		// Create a button to return to the main menu
		var mainMenuBtn:FlxButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height * 2 / 3, "", onMainMenu);
		add(mainMenuBtn);

		mainMenuBtn.loadGraphic(Paths.image("Return"));
		mainMenuBtn.scrollFactor.set(0, 0); // Make the button not scroll with the camera

		mainMenuBtn.x = -12;
		mainMenuBtn.y = 525;

		// I don't think this is needed?? ->persistentUpdate = persistentDraw = true;<-
		// for later :)
		// var sprite:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('gallery'));
		// add(sprite);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = 3;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.updateHitbox();
			trace(spr.ID);

			if (spr.ID == curSelected)
			{
                if (curSelected == 0)
				{
					spr.x = spr.x + 50;
				}

				else if (curSelected == 1)
				{
					spr.x = spr.x + 20;
				}

				else if (curSelected == 2)
				{
					spr.x = spr.x + 5;
				}
				
				else if (curSelected == 3)
				{
					spr.x = spr.x + 1;
				}
				// spr.centerOffsets();
			}
		});
	}

	private function onDeactivate(e:flash.events.Event):Void
	{
		FlxG.switchState(new MainMenuState());
		Global.gcheck = "1";
		Global.mcheck = "";
		Global.mcheck0 = "0";
	}

	private function onMainMenu():Void
	{
		// Return to the main menu state
		FlxG.switchState(new MainMenuState());
		FlxG.mouse.visible = false;
		Global.gcheck = "1";
		Global.mcheck = "";
		Global.mcheck0 = "0";
	}

	private function waitfuckgoback():Void
	{
		FlxG.switchState(new GalleryMenuState());
	}

	private function onGalleryItem1():Void
	{
		FlxG.switchState(new GalleryMenuState());
	}

	private function onGalleryItem2():Void
	{
		// Log a message to the console
		trace("Clicked Gallery Item 2");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (controls.UI_LEFT_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeItem(-1);
		}
	
		if (controls.UI_RIGHT_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeItem(1);
		}
	}
}
