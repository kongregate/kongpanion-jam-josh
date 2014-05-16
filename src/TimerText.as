package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;

  public class TimerText extends FlxGroup
  {
    private var placeText:FlxText;

    public function TimerText() {
      super();

      placeText = new FlxText(0, 0, FlxG.width, "2nd");
      placeText.alignment = "center";
      placeText.font = "zerofour";
      placeText.size = 64;
      placeText.color = 0xff175f43;
      placeText.scrollFactor.x = placeText.scrollFactor.y = 0;
      add(placeText);
    }

    public override function update():void {
      super.update();
    }
  }
}
