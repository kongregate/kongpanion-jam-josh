package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;
  import com.greensock.*;
  import com.greensock.easing.*;

  public class TitleState extends FlxState
  {
    private var kongpanion:FlxSprite;
    private var trackAndField:FlxSprite;

    private var scrollingBackground:ScrollingBackground;
    private var transitionGroup:TransitionGroup;
    private var canStart:Boolean = false;

    private var clickText:FlxText;

    override public function create():void {
      scrollingBackground = new ScrollingBackground();
      add(scrollingBackground);

      kongpanion = new FlxSprite();
      kongpanion.loadGraphic(Assets.KongpanionTitle);
      kongpanion.y = -150;
      kongpanion.alpha = 0;
      add(kongpanion);

      trackAndField = new FlxSprite();
      trackAndField.loadGraphic(Assets.TrackAndFieldTitle);
      trackAndField.x = 150;
      trackAndField.alpha = 0;
      add(trackAndField);

      clickText = new FlxText(0, 450, FlxG.width, "CLICK TO START");
      clickText.alignment = "center";
      clickText.font = "zerofour";
      clickText.size = 32;
      clickText.color = 0xff175f43;
      clickText.alpha = 0;
      add(clickText);

      transitionGroup = new TransitionGroup();
      add(transitionGroup);
      transitionGroup.go(function():void {
        canStart = true;
        TweenMax.to(kongpanion, 0.5, {
          y: 0,
          alpha: 1,
          ease:Quart.easeOut
        });
        TweenMax.to(trackAndField, 0.5, {
          x: 0,
          alpha: 1,
          ease:Quart.easeOut
        });
        TweenMax.to(clickText, 0.5, {
          y: 300,
          alpha: 1,
          ease:Quart.easeOut
        });
      });
    }

    override public function update():void {
      if(FlxG.mouse.justPressed() && canStart) {
        canStart = false;
        TweenMax.to(kongpanion, 0.5, {
          y: -150,
          alpha: 0,
          ease:Quart.easeIn
        });
        TweenMax.to(clickText, 0.5, {
          y: 450,
          alpha: 0,
          ease:Quart.easeIn
        });
        TweenMax.to(trackAndField, 0.5, {
          x: 150,
          alpha: 0,
          ease:Quart.easeIn,
          onComplete: function():void {
            transitionGroup.go(function():void {
              FlxG.switchState(new SelectKongpanionState());
            });
          }
        });
      }
      super.update();
    }
  }
}
