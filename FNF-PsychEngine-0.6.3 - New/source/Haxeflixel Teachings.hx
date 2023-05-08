import flixel.FlxG; // <- Imports Flixel Game (All the stuff that you see on screen)
import flixel.FlxState; // <- Imports Flixel State (Makes its own state!)
import flixel.ui.FlxButton; // <- Imports Flixel Button (Makes buttons you can click)
import flixel.text.FlxText; // <- Imports Flixel Text (Makes text you can read)
import flixel.FlxSprite; // <- Flixel Sprites (Makes graphics! and displays images/animations)
#if desktop // <- If it's desktop...
import Discord.DiscordClient; // <- Initialize (Start) the Discord RPC (Shows what game you're playing) 
#end
import flixel.system.FlxSound; // <- Initialize Flixel Sound! (For playing sounds and music)


// With these imports, they are special. They borrow code from other files. By importing them into this code.
import Global; // <- Imports the code the "Global" file
import HealthIcon; // <- Imports the code from "HealthIcon" file
import MenuCharacter; // <- Imports the code from "MenuCharacter" file

// More complicated imports.
// ------------------------
// Imports FlxObject, which adds Velocity, Friction and Accleration to the Flixel Sprite
// Can also change the Angle, and is used for collision with other objects (Bounding Boxes)
import flixel.FlxObject;
// Imports Flixel Camera, which then you can mess around with how the camera works
import flixel.FlxCamera;
// It imports Flixel transitions through an addon, and says it shows a transition through changing states
import flixel.addons.transition.FlxTransitionableState;
// Imports Flixel Flicking, can adjust how fast or how long it flickers the screen
import flixel.effects.FlxFlicker;
// Not sure what this is about, but it's for the sprite frames.
import flixel.graphics.frames.FlxAtlasFrames;
// Dunno what this is either.
import flixel.group.FlxGroup.FlxTypedGroup;
// Imports MATH!
import flixel.math.FlxMath;
// Works with the tween import to make it easier to transition between the beginning and the end of the tweens. TLDR; Makes animations smoother.
import flixel.tweens.FlxEase;
// You know what this is. Animation of Sprites. Can squash and stretch
import flixel.tweens.FlxTween;
// Colors!
import flixel.util.FlxColor;
// Uh... not sure
import lime.app.Application;
// Imports and runs the code for the hx "Achievements" file
import Achievements;
// Imports and runs the code for the hx "MasterEditorMenu" file inside the editors folder
import editors.MasterEditorMenu;
// Imports the codeblocks used for getting key inputs from the player's keyboard
import flixel.input.keyboard.FlxKey;
// Is used for using more advanced codeblocks on strings
using StringTools;
// ------------------------

// WHAT IS MOST IMPORTANT IS ADDING THE ; AT THE END OF EVERY LINE IN AND OUT OF CLASSES + FUNCTIONS!!!
// Keep in mind that none of the code in the file won't run if you don't call this:

class HaxeTeachings extends FlxState // <- This says that the class "HaxeTeachings" uses/extends FlxState (For making states)
{
    // This is main! Anything that comes after isn't.
    // This is also where most of the code for creating stuff goes.
    override public function create():Void // <- Create/override public (across this entire class) function create which is Void. This function is very import for giving the class "HaxeTeachings" functionality.
    {
        // Flixel Game.sound.music.fadeOut(0.1) <- 0.1 SECOND fade out
        FlxG.sound.music.fadeOut(0.1);
        // Flixel Game.sound.music is set to null
		FlxG.sound.music = null;

        // IF gcheck2 from Global file is equal to the string of "0"
        // AND if Flixel Game.sound.music is equal to null
        // THEN play music from assets/music -> tfupgrademachine.ogg with volume of 1
        if (Global.gcheck2 == "0")
        {
            if (FlxG.sound.music == null)
            {
                FlxG.sound.playMusic("assets/music/tfupgrademachine.ogg", 1);
            }
        }
        
        // Makes a new FlxSprite called gallerybg at position 0,0 and loads it from images file
        var gallerybg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('galleryBG'));
        // Actually adds that FlxSprite to the screen
		add(gallerybg);

		// Creates a variable textbox called "Gallery Menu", at the X coord of 0, Y coord of 4 and with a width of 12
		var titleText:FlxText = new FlxText(0, 4, 12, "Gallery Menu");
        // Sets the formatting of title text, the font used (null = default), at a size of 24, with the color of white and an alignment of "center"
		titleText.setFormat(null, 24, 0xffffffff, "center");
        // Adds the text to the screen
		add(titleText);

		// Creates a variable button to return to the main menu with the width of half the screen and with a height times 2/3 of the screen.
        // The "Main Menu" is the text displayed inside the button, and it runs a function called "onMainMenu" when clicked
		var mainMenuBtn:FlxButton = new FlxButton(FlxG.width / 2, FlxG.height * 2 / 3, "Main Menu", onMainMenu);
        // Adds button to the screen
		add(mainMenuBtn);

        // After you add the button to the screen you can adjust where it's located! Using X (Horizontal) and Y (Vertical)
	    mainMenuBtn.x = 600;
		mainMenuBtn.y = 300;

        // Shows the systems mouse cursor instead of flixels
		FlxG.mouse.useSystemCursor = true;
        // It "listens" (watches) for when the window loses focus, and then runs the "onDeactivate" function
		FlxG.stage.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
    }
    // ----------------------------------
    // Other stuff you should know about!

    class private function OtherStuffInOtherFiles()
    {
        // makes a new variable called "MenuItems" and uses the FlxTypedGroup to declare it as an FlxSprite
        var menuItems:FlxTypedGroup<FlxSprite>;
        
        // makes a new variable called "optionShit" and declares it as an Array (list/group of things) that contains strings
        // This is how I can add the custom sprites for the options on the main menu
        var optionShit:Array<String> = [
            'story_mode',
            'freeplay',
            'options',
            'gallery' // #if MODS_ALLOWED 'mods', #end
            // 'credits',
            // #if !switch 'donate', #end
        ];


        if (!selectedSomethin)
        {
            // These are not the offical commands! They use code from another file in this list.

            // If the player presses the up keybind...
            if (controls.UI_UP_P)
            {
                // Play the sound of "ScrollMenu"
                FlxG.sound.play(Paths.sound('scrollMenu'));
                // Remove 1 from a variable which the cursor is greater than or equal to
                changeItem(-1);
            }
            
            // Same but in reverse
            if (controls.UI_DOWN_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(1);
            }

            // If the player presses the backspace key...
            if (controls.BACK)
            {
                // "selectedSomethin" is equal to the true boolean (boolean = true & false)
                selectedSomethin = true;
                // It plays the cancel menu sound in the "sounds" folder
                FlxG.sound.play(Paths.sound('cancelMenu'));
                // It runs and creates a new instance of TitleState
                MusicBeatState.switchState(new TitleState());
            }

            // If the player presses the enter key...
            if (controls.ACCEPT)
            {
                // if the cursor is on the "donate" option
                if (optionShit[curSelected] == 'donate')
                {
                    // Open the browser up to this website
                    CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
                }
                else
                {
                    // selectedSomethin is set to true
                    selectedSomethin = true;
                    // It plays the confirmMenu sound in the "sounds" folder
                    FlxG.sound.play(Paths.sound('confirmMenu'));
                    
                    // If the players settings prefers flashing...
                    if (ClientPrefs.flashing)
                    {
                        // Flicker the magenta "object"/jpg/animation for 1.1 seconds at an interval of 0.15 and when it ends it is invisible (if set to true it will stay visible after it ends)
                        FlxFlicker.flicker(magenta, 1.1, 0.15, false);
                    }
                    // For each menu item in MenuItems give it a FlxSprite using the function "spr"
                    menuItems.forEach(function(spr:FlxSprite)
                    {
                        // if the cursor DOES NOT equal the sprite ID
                        if (curSelected != spr.ID)
                        {
                            // kill the sprite, basically
                            FlxTween.tween(spr, {alpha: 0}, 0.4, {
                                ease: FlxEase.quadOut,
                                onComplete: function(twn:FlxTween)
                                {
                                    spr.kill();
                                }
                            });
                        }
                        else
                        {
                            // Flicker the spr with a duration of 1 and an interval of 0.06, with an endvisibility of false and a forcerestart of false which on completion calls back Flixel Flicker
                            FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
                            {
                                // DaChoice is a string which is equals to Optionshits cursor
                                var daChoice:String = optionShit[curSelected];
                                
                                // When a choice is made on where to go...
                                switch (daChoice)
                                {
                                    // Switch to story mode file/menu!
                                    case 'story_mode':
                                        // Run and create a new instance of StoryMenuState using MusicBeatState
                                        MusicBeatState.switchState(new StoryMenuState());

                                    // Switch to freeplay mode file/menu!
                                    case 'freeplay':
                                        // Run and create a new instance of FreeplayState using MusicBeatState
                                        MusicBeatState.switchState(new FreeplayState());
                                    
                                    // If mods are allowed...
                                    #if MODS_ALLOWED
                                    // Switch to mods file/menu
                                    case 'mods':
                                        // Run and create a new instance of ModsMenuState using MusicBeatState
                                        MusicBeatState.switchState(new ModsMenuState());
                                    #end

                                    // Switch to awards file/menu!
                                    case 'awards':
                                        // Run and create a new instance of AchievementsMenuState using MusicBeatState
                                        MusicBeatState.switchState(new AchievementsMenuState());

                                    // Switch to credits file/menu!
                                    case 'credits':
                                        // Run and create a new instance of CreditsState using MusicBeatState
                                        MusicBeatState.switchState(new CreditsState());

                                    // Switch to options file/menu!
                                    case 'options':
                                        LoadingState.loadAndSwitchState(new options.OptionsState());
                                    
                                    // Switch to gallery file/menu!
                                    case 'gallery':
                                        // Run and create a new instance of GalleryMenuState using MusicBeatState
                                        MusicBeatState.switchState(new GalleryMenuState());
                                    
                                        // SUPPOSED to play cutscene of cyberpunk2077, forgot what false is for.
                                        playCutscene('cyberpunk2077.mp4', false);
                                }
                            });
                        }
                    });
                }
            }
            // If it is desktop...
            #if desktop
            // Else, if any of the debug keys are pressed...
            else if (FlxG.keys.anyJustPressed(debugKeys))
            {
                // SelectedSomethin is equal to true
                selectedSomethin = true;
                // Run and create a new instance of MasterEditorMenu using MusicBeatState
                MusicBeatState.switchState(new MasterEditorMenu());
            }
            #end
        }

        // Updates the elapsed time, most likely for discord RPC
        super.update(elapsed);

        // For each menu item run function FlxSprite using "spr"
		menuItems.forEach(function(spr:FlxSprite)
		{
            // Centers the screen on every sprite you select. That is why X is there.
			spr.screenCenter(X);
		});

        // It makes a new function called changeItem with the arguments creating a variable called "huh" as an Integer (Whole Number only) and sets it to zero
        function changeItem(huh:Int = 0)
            {
                // The cursor is equal to or greater than the variable "huh"
                curSelected += huh;
                
                // If the cursor exceeds (greater than or equal to) the list length of menuItems...
                if (curSelected >= menuItems.length)
                    // Set the cursor back to the first item.
                    curSelected = 0;
                // If the cursor is less than 0...
                if (curSelected < 0)
                    // The cursor is equal to the length of the menuitems minus 1 (eg. the last item)
                    curSelected = menuItems.length - 1;
                 // Same shit. For each menuItem run function "spr" with FlxSprite
                menuItems.forEach(function(spr:FlxSprite)
                {
                    // sprite plays the animation "idle"
                    spr.animation.play('idle');
                    // sprite updates their hitbox everyframe
                    spr.updateHitbox();
        
                    // If the sprites ID is equal to the cursor...
                    if (spr.ID == curSelected)
                    {
                        // Play the sprite animation "selected"
                        spr.animation.play('selected');
                        // make a variable called "add" as a Float (Whole numers and decibels!) and equal it to zero
                        var add:Float = 0;
                        // If the menuitems length is greater than 4...
                        if (menuItems.length > 4)
                        {
                            // The "add" variable is equal to the length of the menu items times 8
                            add = menuItems.length * 8;
                        }
                        // Follows the "midpoint"/middle of the x and y (- variable "add") of the sprites using the "spr" function
                        camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
                        // Center the offsets of the sprites using the "spr" function
                        spr.centerOffsets();
                    }
                });
            }
    }

    // -----------------------------------

    // This makes a PRIVATE function called "onDeactivate", which means it delicated to it's own "category" and you cannot call whatever it makes inside, outside of it.
    // The arguments for "onDeactivate" is ALL the events and is void
    private function onDeactivate(e:flash.events.Event):Void
    {
        // It switches to the "MainMenuState" which is an Haxeflixel file, so basically it runs a new instance of MainMenuState
        FlxG.switchState(new MainMenuState());
        // Stops all the music and sounds
        FlxG.sound.music.stop();
        // Removes the "Listener" that triggers the "onDeactivate" event
        FlxG.stage.removeEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
        // Sets gcheck in Global to 1, and gcheck2 in Global to 0
        Global.gcheck = "1";
        Global.gcheck2 = "0";
    }

    private function onMainMenu():Void
    {
        // Return to the main menu state by running a new instance of MainMenuState
        FlxG.switchState(new MainMenuState());
        // Sets the application to stop using the system cursor
        FlxG.mouse.useSystemCursor = false;
        
        // IGNORE THIS
        FlxG.sound.music.stop();
        FlxG.stage.removeEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
        Global.gcheck = "1";
        Global.gcheck2 = "0";
        // IGNORE THIS
    }

    private function onGalleryItem1():Void
    {
        // Switches and runs a new instance of GalleryMenuSubState1
        FlxG.switchState(new GalleryMenuSubState1());
        Global.gcheck2 = "1";
    }
    
    private function onGalleryItem2():Void
    {
        // PRINTS and displays a message to the console
        trace("Clicked Gallery Item 2");
    }
    




    // Left Over tidbits, not sure if this is important in the code.
    // it OVERRIDES (Replaces) public function "update" with the arguements of the elapsed time as a Float (Whole Number with Decimals for precision)
    override public function update(elapsed:Float):Void
    {
        // super is like admin priviliges on your computer
        // it updates the elapsed time spent in the state/menu
        super.update(elapsed);
    }
}