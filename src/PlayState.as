package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;

  public class PlayState extends FlxState
  {
    [Embed(source = '../data/04b03.ttf', fontFamily="zerofour", embedAsCFF="false")] public var ZeroFour:String;

    private var kongpanionSprite:KongpanionSprite;
    private var scrollingBackground:ScrollingBackground;

    override public function create():void {
      scrollingBackground = new ScrollingBackground();
      add(scrollingBackground);

      //kongpanionSprite = new KongpanionSprite(G.kongpanionDatas[1]);
      //add(kongpanionSprite);

      //FlxG.bgColor = FlxU.makeColorFromHSB(FlxU.getHSB(kongpanionSprite.flatColor)[0], 0.4, 0.7);

      add(new KongpanionGroup(G.kongpanionDatas[1]));

      var overlayGradient:FlxSprite = FlxGradient.createGradientFlxSprite(
        FlxG.width, FlxG.height, [0xff444444, 0xffaaaaaa], 1); 
      overlayGradient.blend = "overlay";
      overlayGradient.alpha = 0.2;
      add(overlayGradient);
    }

    override public function update():void {
      scrollingBackground.backgroundSprite.hueShift++;
      if(FlxG.keys.justPressed("SPACE")) FlxG.switchState(new PlayState());
      super.update();
    }

  }
}
