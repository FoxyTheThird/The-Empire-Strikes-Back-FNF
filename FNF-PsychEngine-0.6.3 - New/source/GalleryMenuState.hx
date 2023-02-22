#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import Global;
import openfl.events.Event;
import openfl.display.Stage;
import openfl.display.Sprite;
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

		var check:String;
		check = "";

		FlxG.sound.music.fadeOut(0.1);
		FlxG.sound.music = null;

		// FlxG.sound.music.name = check;
		var currentMusicName:String;
		currentMusicName = "";

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic("assets/music/tfupgrademachine.ogg", 1);
			currentMusicName = FlxG.sound.music.name;
		}

		var gallerybg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('galleryBG'));
		add(gallerybg);

		// Create a title text
		var titleText:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "Gallery Menu");
		titleText.setFormat(null, 24, 0xffffffff, "center");
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
	}

	private function onMainMenu():Void
	{
		// Return to the main menu state
		FlxG.switchState(new MainMenuState());
		FlxG.mouse.visible = false;
		FlxG.sound.music.stop();
		Global.gcheck = "1";
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