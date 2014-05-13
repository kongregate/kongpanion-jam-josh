package
{
  import org.flixel.*;

  [SWF(width="768", height="432", backgroundColor="#000000")]
  [Frame(factoryClass="Preloader")]

  public class KongpanionGame extends FlxGame
  {
    public function KongpanionGame() {
      FlxG.debug = true;
      FlxG.visualDebug = true;
      //forceDebugger = true;

      super(768,432,MenuState,1,60,60);
    }
  }
}
