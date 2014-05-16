//100 METER DASH
package
{
  import org.flixel.*;
  import com.greensock.*;
  import com.greensock.easing.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;

  public class DashState extends FlxState
  {
    public static const FIELD_SIZE:Number = 8000;
    public static const BORDER_WIDTH:Number = 20;
    public static const TILE_COUNT:Number = 40;

    private var kongpanionSprite:KongpanionSprite;
    private var scrollingBackground:ScrollingBackground;
    private var transitionGroup:TransitionGroup;
    private var dialog:DialogGroup;

    private var player:DashPlayer;
    private var aiPlayers:Array;

    private var completed:int = 0;
    private var place:int = 0;
    private var finished:Boolean = false;

    private function makeFieldStripe(tileWidth:Number, i:int, j:int):void {
      var fieldSprite:FlxSprite;
      fieldSprite = new FlxSprite(BORDER_WIDTH + (i*tileWidth),
                                  FlxG.height-270 + j*((250 - (BORDER_WIDTH*2))/20));
      fieldSprite.makeGraphic(10, (250 - (BORDER_WIDTH*2))/20,
                              j%2 == 0 ? 0xffe2f3ec : 0xff175f43);
      add(fieldSprite); 
      trace(fieldSprite.x);

      fieldSprite = new FlxSprite(10 + BORDER_WIDTH + (i*tileWidth),
                                  FlxG.height-270 + j*((250 - (BORDER_WIDTH*2))/20));
      fieldSprite.makeGraphic(10, (250 - (BORDER_WIDTH*2))/20,
                              j%2 != 0 ? 0xffe2f3ec : 0xff175f43);
      add(fieldSprite); 
    }

    override public function create():void {
      scrollingBackground = new ScrollingBackground();
      add(scrollingBackground);

      //kongpanionSprite = new KongpanionSprite(G.kongpanionDatas[1]);
      //add(kongpanionSprite);

      //FlxG.bgColor = FlxU.makeColorFromHSB(FlxU.getHSB(kongpanionSprite.flatColor)[0], 0.4, 0.7);
      var fieldSprite:FlxSprite = new FlxSprite(0, FlxG.height-250);
      fieldSprite.makeGraphic(FIELD_SIZE, 250, 0xff175f43);
      add(fieldSprite);

      fieldSprite = new FlxSprite(0, FlxG.height-290);
      fieldSprite.makeGraphic(FIELD_SIZE, 250, 0xff29805f);
      add(fieldSprite);

      var tileWidth:Number = (FIELD_SIZE-(BORDER_WIDTH*2))/TILE_COUNT;

      for(var i:int = 0; i*tileWidth < FIELD_SIZE-(BORDER_WIDTH*2); i++) {
        fieldSprite = new FlxSprite(BORDER_WIDTH + (i*tileWidth), FlxG.height-270);
        fieldSprite.makeGraphic(tileWidth,
                                250 - (BORDER_WIDTH*2),
                                i%2 == 0 ? 0xff2b855d : 0xff2f8f65);
        add(fieldSprite); 
        if((i+1)*tileWidth >= FIELD_SIZE-(BORDER_WIDTH*2)) {
          for(var j:int = 0; j < 20; j++) {
            makeFieldStripe(tileWidth, i, j);
          }
        }
      }

      //add(new TimerText());
      var cd:CountDownGroup = new CountDownGroup()
      add(cd);

      G.shuffle();

      aiPlayers = new Array();
      for(var i=0; i < 5; i++) {
        aiPlayers[i] = new DashPlayer(false, i);
        aiPlayers[i].y = 25 + (i * 38);
        add(aiPlayers[i]);
      }

      player = new DashPlayer();
      player.y = 215;
      add(player);

      FlxG.camera.scroll.y = -400;
      TweenMax.to(FlxG.camera.scroll, 3, {
        y: 0,
        ease:Quart.easeOut,
        onComplete: function():void {
          cd.go(function():void {
            FlxG.camera.shake(0.02, 0.2);
            player.started = true;
            for each(var ai:DashPlayer in aiPlayers) {
              ai.started = true;
            }
          });
          //ON YOUR MARK...
        }
      });

      dialog = new DialogGroup();
      add(dialog);

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
      if(FlxG.camera.scroll.x >= FIELD_SIZE - FlxG.width) {
        FlxG.camera.scroll.x = FIELD_SIZE - FlxG.width;
      }
      if (player.x > 7781) {
        if(!player.finished) completed++;
        player.finished = true;
      }
      for each(var ai:DashPlayer in aiPlayers) {
        if (ai.x > 7781) {
          if(!ai.finished) {
            completed++;
            if(!player.finished) place++;
          }
          ai.finished = true;
        }
      }

      if(completed >= 6 && !finished) {
        finished = true;
        dialog.show(place, function():void {
          transitionGroup.go(function():void {
            FlxG.switchState(new SelectKongpanionState());
          });
        });
      }
    }

  }
}
