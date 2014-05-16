package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;
  import com.greensock.*;
  import com.greensock.easing.*;

  public class DialogGroup extends FlxGroup
  {
    private var places:Array = ["1st", "2nd", "3rd", "4th", "5th", "6th"];
    private var dialogSprite:FlxSprite;
    private var placeText:FlxText;

    private var sinRate:Number = 0.6;
    private var sinAmt:Number = 0;
    private var floatAmt:Number = 5;

    private var onCompleteCallback:Function;
    private var readyToGo:Boolean;

    public function DialogGroup() {
      dialogSprite = new FlxSprite();
      dialogSprite.loadGraphic(Assets.Dialog);
      dialogSprite.alpha = 0;
      dialogSprite.x = (FlxG.width-dialogSprite.width)/2;
      dialogSprite.scrollFactor.x = dialogSprite.scrollFactor.y = 0;
      add(dialogSprite);

      placeText = new FlxText(0, -100, FlxG.width, '');
      placeText.alignment = "center";
      placeText.font = "zerofour";
      placeText.size = 128;
      placeText.alpha = 0;
      placeText.color = 0xff7fdab3;
      placeText.scrollFactor.x = placeText.scrollFactor.y = 0;
      add(placeText);
    }

    public function show(place:int, callback:Function):void {
      onCompleteCallback = callback;
      placeText.text = places[place];
      TweenMax.to(dialogSprite, 0.5, {
        y: (FlxG.height - dialogSprite.height-1)/2,
        alpha: 1,
        ease:Quart.easeOut
      });
      TweenMax.to(placeText, 0.5, {
        alpha: 1,
        ease:Quart.easeOut,
        onComplete: function():void {
          readyToGo = true;
        }
      });
    }

    public override function update():void {
      super.update();
      sinAmt += FlxG.elapsed / sinRate;
      dialogSprite.offset.y = Math.sin(sinAmt) * floatAmt;
      placeText.y = dialogSprite.y + 70 - dialogSprite.offset.y;

      if(readyToGo && FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER")) {
        readyToGo = false;
        TweenMax.to(dialogSprite, 0.5, {
          y: FlxG.height - dialogSprite.height,
          alpha: 0,
          ease:Quart.easeIn
        });
        TweenMax.to(placeText, 0.5, {
          alpha: 0,
          ease:Quart.easeIn,
          onComplete: onCompleteCallback
        });
      }
    }
  }
}
