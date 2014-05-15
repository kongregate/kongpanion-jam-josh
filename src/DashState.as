//100 METER DASH
package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;

  public class DashState extends FlxState
  {
    private var kongpanionSprite:KongpanionSprite;
    private var scrollingBackground:ScrollingBackground;
    private var transitionGroup:TransitionGroup;

    private var player:DashPlayer;

    override public function create():void {
      scrollingBackground = new ScrollingBackground();
      add(scrollingBackground);

      //kongpanionSprite = new KongpanionSprite(G.kongpanionDatas[1]);
      //add(kongpanionSprite);

      //FlxG.bgColor = FlxU.makeColorFromHSB(FlxU.getHSB(kongpanionSprite.flatColor)[0], 0.4, 0.7);
      var fieldSprite:FlxSprite = new FlxSprite(10, FlxG.height-300);
      fieldSprite.makeGraphic(2000, 300, 0xff175f43);
      add(fieldSprite);

      player = new DashPlayer();
      add(player);

      transitionGroup = new TransitionGroup();
      add(transitionGroup);
      transitionGroup.go();
    }

    override public function update():void {
      if(FlxG.keys.justPressed("Q")) FlxG.switchState(new DashState());
      super.update();
    }

  }
}
