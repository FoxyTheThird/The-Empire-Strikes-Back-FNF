#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import openfl.events.Event;
import openfl.display.Stage;
import openfl.display.Sprite;
import flixel.util.FlxColor;
import Global;
import Sys;
import VideoPlayer;

class GalleryMenuState extends FlxState
{
	override public function create():Void
	{
		FlxG.mouse.useSystemCursor = false;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Gallery", null);
		#end

		var gallerybg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('galleryBG'));
		add(gallerybg);

		// Create a title text
		var titleText:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "Gallery Menu");
		titleText.setFormat(null, 24, 0xffffffff, "center");
		titleText.setBorderStyle(OUTLINE, FlxColor.BLACK, 2);
		add(titleText);

		// Create a button to return to the main menu
		var mainMenuBtn:FlxButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height * 2 / 3, "Main Menu", onMainMenu);
		add(mainMenuBtn);

		// Create buttons for each gallery item
		var galleryItem1Btn:FlxButton = new FlxButton(FlxG.width / 4, FlxG.height / 2, "Scrapped Art", onGalleryItem1);
		add(galleryItem1Btn);

		var galleryItem2Btn:FlxButton = new FlxButton(FlxG.width * 3 / 4 - 80, FlxG.height / 2, "Video test", onGalleryItem2);
		add(galleryItem2Btn);

		var secretGalleryBtn:FlxButton = new FlxButton(FlxG.width * 3 / 4 - 80, FlxG.height / 2, "Secret", gallerysecret);
		add(secretGalleryBtn);

		secretGalleryBtn.x = 600;
		secretGalleryBtn.y = 300;

		FlxG.mouse.visible = true;

		// Detect when the window loses focus
		var stage:Stage = FlxG.stage;
		stage.addEventListener(Event.DEACTIVATE, function(event:Event)
		{
			// Hide the mouse cursor
			FlxG.mouse.visible = false;
		});

		// Detect when the window regains focus
		stage.addEventListener(Event.ACTIVATE, function(event:Event)
		{
			// Show the mouse cursor
			FlxG.mouse.visible = true;
		});

		music();
	}

	public function music():Void
	{
		if (FlxG.sound.music == null && Global.mcheck0 == "0")
		{
			FlxG.sound.music.stop();
			FlxG.sound.music.loadEmbedded("tfupgrademachine.mp3");
			Global.mcheck0 == "1";
		}

		if (Global.mcheck != "tfupgrademachine")
		{
			FlxG.sound.playMusic("assets/music/tfupgrademachine.ogg", 1);
			Global.mcheck = "tfupgrademachine";
		}
	}

	private function onMainMenu():Void
	{
		// Return to the main menu state
		FlxG.switchState(new MainMenuState());
		FlxG.mouse.visible = false;
		FlxG.sound.music.stop();
		Global.gcheck = "1";
		Global.mcheck = "";
		Global.mcheck0 = "0";
	}

	private function onGalleryItem1():Void
	{
		FlxG.switchState(new GalleryMenuSubState1());
	}

	private function onGalleryItem2():Void
	{
		new YouTubeLauncher("dQw4w9WgXcQ", GalleryMenuState);
	}

	private function gallerysecret():Void
	{
		// Log a message to the console
		trace("Clicked Gallery secret");
	}
}
