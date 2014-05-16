//100 METER DASH
package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;

  public class DashState extends FlxState
  {
    public static const FIELD_SIZE:Number = 4000;
    public static const BORDER_WIDTH:Number = 20;
    public static const TILE_COUNT:Number = 20;

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
      fieldSprite.makeGraphic(FIELD_SIZE, 250, 0xff175f43);
      add(fieldSprite);

      fieldSprite = new FlxSprite(10, FlxG.height-310);
      fieldSprite.makeGraphic(FIELD_SIZE, 250, 0xff29805f);
      add(fieldSprite);

      var tileWidth:Number = (FIELD_SIZE-(BORDER_WIDTH*2))/TILE_COUNT;

      for(var i:int = 0; i*tileWidth < FIELD_SIZE-(BORDER_WIDTH*2); i++) {
        fieldSprite = new FlxSprite(10 + BORDER_WIDTH + (i*tileWidth), FlxG.height-290);
        fieldSprite.makeGraphic(tileWidth, 250 - (BORDER_WIDTH*2), i%2 == 0 ? 0xff2b855d : 0xff2f8f65);
        add(fieldSprite); 
      }

      player = new DashPlayer();
      add(player);

      transitionGroup = new TransitionGroup();
      add(transitionGroup);
      transitionGroup.go();
    }

    override public function update():void {
      if(FlxG.keys.justPressed("Q")) FlxG.switchState(new DashState());
      super.update();
      if (player.x > 200) {
        FlxG.camera.scroll.x = player.x - 200;
      }
      if(FlxG.camera.scroll.x >= FIELD_SIZE - FlxG.width + 10) {
        FlxG.camera.scroll.x = FIELD_SIZE - FlxG.width + 10;
      }
    }

  }
}
