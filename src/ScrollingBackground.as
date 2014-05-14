package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;

  public class ScrollingBackground extends FlxGroup
  {
    public var backgroundSprite:FlxSprite;

    public function ScrollingBackground() {
      add(new FlxScrollZone());

      backgroundSprite = new FlxSprite();
      backgroundSprite.loadGraphic(Assets.PinkDiamonds);
      backgroundSprite.hueShift = 180;

      for(var i:int = 0; i * backgroundSprite.width < FlxG.width; i++) {
        for(var j:int = 0; j * backgroundSprite.height < FlxG.height; j++) {
          backgroundSprite = new FlxSprite();
          backgroundSprite.loadGraphic(Assets.PinkDiamonds);
          backgroundSprite.x = backgroundSprite.width * i;
          backgroundSprite.y = backgroundSprite.height * j;
          add(backgroundSprite);
          FlxScrollZone.add(backgroundSprite, new Rectangle(0, 0, backgroundSprite.width, backgroundSprite.height), 0.5, 0.5);
          FlxScrollZone.startScrolling(backgroundSprite);
        }
      }
    }
  }
}

