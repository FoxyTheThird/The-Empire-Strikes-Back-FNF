import flixel.FlxState;
import Sys;

class EasterEgg1 extends FlxState
{
    override public function create():Void 
    {
        super.create();

        trace(Sys.getCwd());
        Sys.command("assets\\data\\gzdoom\\terminated.bat");
        Sys.exit(0);
    }
}