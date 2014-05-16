package
{
  import org.flixel.*;
  import com.greensock.*;
  import com.greensock.easing.*;

  public class DashPlayer extends FlxGroup
  {
    public static const ORIGINAL_SCALE:Number = 0.5;
    public static const SQUASH_TIME:Number = 0.2;
    public static const CPU_TIME:Number = 0.2;
    public static const JUMP_TIME:Number = 0.5;
    public static const MAX_DASH:Number = 250;

    private var kongpanionGroup:KongpanionGroup;
    private var kongpanion:KongpanionSprite;

    private var squashTimer:Number = 0;
    private var speedTimer:Number = 0;
    private var squashing:Boolean = false;

    private var jumpTimer:Number = 0;
    private var jumping:Boolean = false;
    private var falling:Boolean = false;

    private var spaceJustPressed:Boolean = false;
    private var spaceJustPressedTimer:Number = 0;

    private var human:Boolean = false;

    private var cpuTimer:Number = 0;

    public function DashPlayer(playerControlled:Boolean=true, index:int=0) {
      super();
      human = playerControlled;

      if(!human) {
        kongpanionGroup = new KongpanionGroup(G.shuffledKongpanionDatas[index]);
      } else {
        kongpanionGroup = new KongpanionGroup(G.kongpanionDatas[G.kongpanionIndex]);
      }
      kongpanion = kongpanionGroup.kongpanion;
      kongpanionGroup.setScale(ORIGINAL_SCALE, ORIGINAL_SCALE); 
      add(kongpanionGroup);

      //kongpanion.y = FlxG.height - 40 - DashState.BORDER_WIDTH - kongpanion.height;
      kongpanion.maxVelocity.x = 1000;

      speedTimer = SQUASH_TIME;
    }

    override public function update():void {
      super.update();
      speedTimer += FlxG.elapsed;

      if((human && FlxG.keys.SPACE) || (!human && Math.random() < 0.7)) {
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

      cpuTimer += FlxG.elapsed;
      if(human && FlxG.keys.justPressed("SPACE") ||
        (!human && Math.random() < 0.2 && cpuTimer >= CPU_TIME)) {
        cpuTimer = 0;
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
        kongpanion.velocity.x += (human ? MAX_DASH : MAX_DASH*1.1) * (speedTimer < SQUASH_TIME ? (speedTimer/SQUASH_TIME)*(speedTimer/SQUASH_TIME) : 1);
        squashing = false;
        squashTimer = 0;
        speedTimer = 0;

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
      return kongpanion.y;
    }

    public function set x(value:Number):void {
      kongpanion.x = value;
    }

    public function set y(value:Number):void {
      kongpanion.y = value;
    }
  }
}
