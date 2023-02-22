import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxSprite;
import Global;

// import openfl.Assets;
// import flash.display.Sprite;
// import gif.AnimatedGif;
// import haxe.io.Bytes;
class GalleryMenuSubState1 extends FlxState
{
	override public function create():Void
	{
		var gallerybg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('galleryBG'));
		add(gallerybg);

		// var bytes:Bytes = Bytes.ofString(Assets.getText("assets/images/gallery/testing.gif"));
		// var gif1 = new AnimatedGif(bytes);
		// this.add(gif1);
		// gif1.y = 500;
		// gif1.x = 300;
		// gif1.play();
		// gif1.rotation = 32;

		// bytes = haxe.io.Bytes.ofString(Assets.getText("assets/images/gallery/testing.gif"));
		// this.add(new AnimatedGif(bytes).play());

		var galleryimage1:FlxSprite = new FlxSprite(400, 300).loadGraphic(('assets/images/gallery/image2.png'));
		add(galleryimage1);

		// Create a title text
		var titleText:FlxText = new FlxText(450, 20, FlxG.width, "Scrapped Art");
		titleText.setFormat(null, 50, 0xffffff);
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

	private function onDeactivate(e:flash.events.Event):Void
	{
		FlxG.switchState(new MainMenuState());
		Global.gcheck = "1";
	}

	private function onMainMenu():Void
	{
		// Return to the main menu state
		FlxG.switchState(new MainMenuState());
		FlxG.mouse.visible = false;
		Global.gcheck = "1";
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
	}
}
