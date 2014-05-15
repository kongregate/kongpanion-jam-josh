package
{
  import org.flixel.*;
  import com.greensock.*;
  import com.greensock.easing.*;

  public class DashPlayer extends FlxGroup
  {
    public static const ORIGINAL_SCALE:Number = 0.5;
    public static const SQUASH_TIME:Number = 0.25;

    private var kongpanionGroup:KongpanionGroup;
    private var kongpanion:KongpanionSprite;

    private var squashTimer:Number = 0;
    private var squashing:Boolean = false;
    private var jumping:Boolean = false;

    public function DashPlayer() {
      super();
      kongpanionGroup = new KongpanionGroup(G.kongpanionDatas[G.kongpanionIndex]);
      kongpanion = kongpanionGroup.kongpanion;
      kongpanionGroup.setScale(ORIGINAL_SCALE, ORIGINAL_SCALE); 
      add(kongpanionGroup);
    }

    override public function update():void {
      super.update();
      if(FlxG.keys.SPACE) {
        kongpanion.drag.x = 300;
        squashTimer += FlxG.elapsed;
        if(squashTimer >= SQUASH_TIME && squashing) {
          jump();
        }
      } else {
        if(squashing) unSquash();
        if(!jumping) kongpanion.drag.x = 800;
      }
      if(FlxG.keys.justPressed("SPACE")) {
        kongpanion.velocity.x += 500;
        squashing = false;
        squashTimer = 0;

        TweenMax.to(kongpanionGroup, 0.25, {
          baseOffset: -25,
          ease:Quart.easeOut
        });

        TweenMax.to(kongpanion.scale, 0.1, {
          y: ORIGINAL_SCALE * 0.75,
          x: ORIGINAL_SCALE * 1.25,
          ease:Quart.easeIn,
          onComplete: function():void {
            squashing = true;
          }
        });
      }
    }

    private function unSquash():void {
      squashing = false;
      squashTimer = 0;

      TweenMax.to(kongpanion.scale, 0.5, {
        y: ORIGINAL_SCALE,
        x: ORIGINAL_SCALE,
        ease:Quart.easeOut
      });

      TweenMax.to(kongpanionGroup, 1, {
        baseOffset: 0,
        ease:Quart.easeOut
      });
    }

    private function jump():void {
      jumping = true;
      squashing = false;
      squashTimer = 0;

      TweenMax.to(kongpanionGroup, 1, {
        baseOffset: 40,
        ease:Quart.easeOut
      });

      TweenMax.to(kongpanion.scale, 0.1, {
        y: ORIGINAL_SCALE * 1.25,
        x: ORIGINAL_SCALE * 0.75,
        ease:Quart.easeIn,
        onComplete: function():void {
          new FlxTimer().start(0.5, 1, function():void {
            TweenMax.to(kongpanion.scale, 0.5, {
              y: ORIGINAL_SCALE,
              x: ORIGINAL_SCALE,
              ease:Quad.easeIn,
              onComplete: function():void {
                TweenMax.to(kongpanion.scale, 0.1, {
                  y: ORIGINAL_SCALE * 0.9,
                  x: ORIGINAL_SCALE * 1.1,
                  ease:Quart.easeOut,
                  onComplete: function():void {
                    TweenMax.to(kongpanion.scale, 0.25, {
                      y: ORIGINAL_SCALE,
                      x: ORIGINAL_SCALE,
                      ease:Quad.easeIn
                    });
                    TweenMax.to(kongpanionGroup, 0.25, {
                      baseOffset: 0,
                      ease:Quad.easeIn
                    });
                  }
                });
              }
            });
            TweenMax.to(kongpanionGroup, 0.5, {
              baseOffset: -15,
              ease:Quad.easeIn,
              onComplete: function():void {
                jumping = false;
              }
            });
          });
        }
      });
    }
  }
}
