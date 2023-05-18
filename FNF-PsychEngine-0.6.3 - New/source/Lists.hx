import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxState;

class RandomQuote extends FlxState
{
	var quoteList:Array<String> = [
		"Fuck you! You fuckin' dick!",
		"It's a stone Luigi... You didn't make it.",
		"When life gives you lemons, don't make lemonade. Make life take the lemons back! Get mad! I don't want your damn lemons, what the hell am I supposed to do with these? Demand to see life's manager! Make life rue the day it thought it could give Cave Johnson lemons! Do you know who I am? I'm the man who's gonna burn your house down! With the lemons! I'm gonna get my engineers to invent a combustible lemon that burns your house down!"
	];

	var quoteDisplay:FlxText;

	override public function create():Void
	{
		// Create the initial quote display
		quoteDisplay = new FlxText(500, 500, FlxG.width);
		quoteDisplay.alignment = "center";
		quoteDisplay.size = 20;
		add(quoteDisplay);

		// Start the timer to change the quote after 3 to 4 seconds
		new FlxTimer().start(3.0, changeQuote, 1);
	}

	private function changeQuote(timer:FlxTimer):Void
	{
		// Generate a random index
		var randomIndex:Int = Math.floor(Math.random() * quoteList.length) % quoteList.length;

		// Update the quote display with the new quote
		quoteDisplay.text = quoteList[randomIndex];

		// Restart the timer for the next quote change
		new FlxTimer().start(3.0, changeQuote, 1);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		// Update game logic here
	}
}
