package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;
  import com.greensock.*;
  import com.greensock.easing.*;

  public class SelectKongpanionState extends FlxState
  {
    private var scrollingBackground:ScrollingBackground;
    private var transitionGroup:TransitionGroup;

    private var selectText:FlxText;

    private var kongpanionTexts:Array = new Array();
    private var kongpanions:Array = new Array();
    private var kongpanionIndex:int=0;

    private var canSelect:Boolean = false;

    override public function create():void {
      scrollingBackground = new ScrollingBackground();
      add(scrollingBackground);

      selectText = new FlxText(0, -130, FlxG.width, "SELECT KONGPANION");
      selectText.alignment = "center";
      selectText.font = "zerofour";
      selectText.size = 32;
      selectText.color = 0xff175f43;
      selectText.alpha = 0;
      add(selectText);

      for(var i:int = 0; i < G.kongpanionDatas.length; i++) {
        kongpanionTexts[i] = new FlxText(0, 350, FlxG.width,
          G.kongpanionDatas[i].isOwned ? G.kongpanionDatas[i].name.toUpperCase() : '?????');
        kongpanionTexts[i].alignment = "center";
        kongpanionTexts[i].font = "zerofour";
        kongpanionTexts[i].size = 32;
        kongpanionTexts[i].color = 0xff175f43;
        kongpanionTexts[i].alpha = 0;
        add(kongpanionTexts[i]);

        kongpanions[i] = new KongpanionGroup(G.kongpanionDatas[i], !G.kongpanionDatas[i].isOwned);
        kongpanions[i].kongpanion.alpha = 1;
        kongpanions[i].kongpanion.y = FlxG.height/2 - kongpanions[i].kongpanion.height/2;
        kongpanions[i].kongpanion.x = 450;
        kongpanions[i].kongpanion.alpha = 0;
        kongpanions[i].shadow.alpha = 0;
        add(kongpanions[i]);
      }

      kongpanionTexts[0].y = 500;

      transitionGroup = new TransitionGroup();
      add(transitionGroup);
      transitionGroup.go(function():void {
        TweenMax.to(selectText, 0.5, {
          y: 20,
          alpha: 1,
          ease:Quart.easeOut
        });
        TweenMax.to(kongpanionTexts[0], 0.5, {
          y: 350,
          alpha: 1,
          ease:Quart.easeOut
        });
        TweenMax.to(kongpanions[0].kongpanion, 0.5, {
          x: FlxG.width/2 - kongpanions[0].kongpanion.width/2,
          alpha: 1,
          ease:Quart.easeOut,
          onComplete: function():void {
            canSelect = true;
          }
        });
      });
    }

    override public function update():void {
      super.update();
      if(!canSelect) return;

      if(FlxG.keys.justPressed("RIGHT")) {
        TweenMax.to(kongpanionTexts[kongpanionIndex], 0.25, {
          x: -100,
          alpha: 0,
          ease:Quart.easeOut
        });
        TweenMax.to(kongpanions[kongpanionIndex].kongpanion, 0.25, {
          x: 300,
          alpha: 0,
          ease:Quart.easeOut
        });

        kongpanionIndex++;
        if(kongpanionIndex >= kongpanions.length) kongpanionIndex = 0;
        kongpanionTexts[kongpanionIndex].x = 100;
        kongpanions[kongpanionIndex].kongpanion.x = 450;

        TweenMax.to(kongpanionTexts[kongpanionIndex], 0.25, {
          x: 0,
          alpha: 1,
          ease:Quart.easeOut
        });
        TweenMax.to(kongpanions[kongpanionIndex].kongpanion, 0.25, {
          x: FlxG.width/2 - kongpanions[0].kongpanion.width/2,
          alpha: 1,
          ease:Quart.easeOut
        });
      }

      if(FlxG.keys.justPressed("LEFT")) {
        TweenMax.to(kongpanionTexts[kongpanionIndex], 0.25, {
          x: 100,
          alpha: 0,
          ease:Quart.easeOut
        });
        TweenMax.to(kongpanions[kongpanionIndex].kongpanion, 0.25, {
          x: 400,
          alpha: 0,
          ease:Quart.easeOut
        });

        kongpanionIndex--;
        if(kongpanionIndex < 0) kongpanionIndex = kongpanions.length - 1;
        kongpanionTexts[kongpanionIndex].x = -100;
        kongpanions[kongpanionIndex].kongpanion.x = 250;

        TweenMax.to(kongpanionTexts[kongpanionIndex], 0.25, {
          x: 0,
          alpha: 1,
          ease:Quart.easeOut
        });
        TweenMax.to(kongpanions[kongpanionIndex].kongpanion, 0.25, {
          x: FlxG.width/2 - kongpanions[0].kongpanion.width/2,
          alpha: 1,
          ease:Quart.easeOut
        });
      }

      if(FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) {
        if(G.kongpanionDatas[kongpanionIndex].isOwned) {
          canSelect = false;
          TweenMax.to(kongpanionTexts[kongpanionIndex], 0.5, {
            y: 500,
            alpha: 0,
            ease:Quart.easeOut
          });
          TweenMax.to(kongpanions[kongpanionIndex].kongpanion, 0.5, {
            alpha: 0,
            ease:Quart.easeOut
          });
          TweenMax.to(kongpanions[kongpanionIndex].kongpanion.scale, 0.5, {
            x: 0,
            y: 0,
            ease:Quart.easeOut
          });
          TweenMax.to(selectText, 0.5, {
            y: -130,
            alpha: 0,
            ease:Quart.easeIn,
            onComplete: function():void {
              transitionGroup.go(function():void {
                FlxG.switchState(new PlayState());
              });
            }
          });
        }
      }
    }
  }
}
