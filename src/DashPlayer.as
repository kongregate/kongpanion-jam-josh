package
{
  import org.flixel.*;
  import com.greensock.*;
  import com.greensock.easing.*;

  public class DashPlayer extends FlxGroup
  {
    public static const ORIGINAL_SCALE:Number = 0.5;
    public static const SQUASH_TIME:Number = 0.2;
    public static const JUMP_TIME:Number = 0.5;

    private var kongpanionGroup:KongpanionGroup;
    private var kongpanion:KongpanionSprite;

    private var squashTimer:Number = 0;
    private var squashing:Boolean = false;

    private var jumpTimer:Number = 0;
    private var jumping:Boolean = false;
    private var falling:Boolean = false;

    private var spaceJustPressed:Boolean = false;
    private var spaceJustPressedTimer:Number = 0;

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
        jumpTimer += FlxG.elapsed;
        if(squashTimer >= SQUASH_TIME && squashing) {
          jump();
        }
        if((jumpTimer >= JUMP_TIME || kongpanion.velocity.x < 100) && falling) {
          fall();
        }
      } else {
        if(squashing) unSquash();
        if(!jumping) {
          kongpanion.drag.x = 800;
        } else {
          kongpanion.drag.x = 100;
        }
        if(falling) {
          fall();
        }
      }
      
      if(FlxG.keys.justPressed("SPACE")) {
        spaceJustPressed = true;
        spaceJustPressedTimer = 0;
      }

      spaceJustPressedTimer += FlxG.elapsed;
      if(spaceJustPressedTimer >= 0.2) {
        spaceJustPressed = false;
      }

      if(spaceJustPressed) {
        if(jumping) return;
        spaceJustPressed = false;
        kongpanion.velocity.x += 300;
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
      jumpTimer = 0;

      TweenMax.to(kongpanionGroup, 0.5, {
        baseOffset: 40,
        ease:Quad.easeOut,
        onComplete: function():void {
          falling = true;
        }
      });

      TweenMax.to(kongpanion.scale, 0.1, {
        y: ORIGINAL_SCALE * 1.25,
        x: ORIGINAL_SCALE * 0.75,
        ease:Quart.easeIn
      });
    }

    private function fall():void {
      jumpTimer = 0;
      falling = false;

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
              jumping = false;
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
        ease:Quad.easeIn
      });
    }

    public function get x():Number {
      return kongpanion.x;
    }

    public function get y():Number {
      return kongpanion.x;
    }
  }
}
