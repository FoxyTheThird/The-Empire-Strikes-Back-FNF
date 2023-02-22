import sys.io.Process;
import flixel.FlxState;
import flixel.FlxG;
import lime.system.System;

class YouTubeLauncher
{
	public function new(videoId:String, returnState:Class<FlxState>)
	{
		// Backup Video Player
		var url = "https://www.youtube.com/watch?v=" + videoId;
		System.openURL(url);

		FlxG.switchState(new GalleryMenuState());
	}
}
