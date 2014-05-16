package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;
  import com.greensock.*;
  import com.greensock.easing.*;

  public class CountDownGroup extends FlxGroup
  {
    private var countDownTexts:Array;
    private var countIndex:int = 0;
    private var onCompleteCallback:Function;

    public function CountDownGroup() {
      super();
      countDownTexts = new Array();
      for(var i:int = 0; i < 4; i++) {
        countDownTexts[i] = new FlxText(100, 185, FlxG.width, i < 3 ? ''+(3-i) : 'START');
        countDownTexts[i].alignment = "center";
        countDownTexts[i].font = "zerofour";
        countDownTexts[i].size = 128;
        countDownTexts[i].alpha = 0;
        countDownTexts[i].color = 0xff175f43;
        //countDownTexts[i].scrollFactor.x = countDownTexts[i].scrollFactor.y = 0;
        add(countDownTexts[i]);
      }
    }

    public function go(callback:Function=null):void {
      if(callback != null) onCompleteCallback = callback;
      if(countIndex > 0) {
        TweenMax.to(countDownTexts[countIndex-1], 0.1, {
          x: -100,
          alpha: 0,
          ease:Quart.easeOut
        });
      }

      TweenMax.to(countDownTexts[countIndex], 0.1, {
        x: 0,
        alpha: 1,
        ease:Quart.easeOut,
        onComplete: function():void {
          countIndex++;
          if(countIndex >= 4) {
            if(onCompleteCallback != null) onCompleteCallback();
            return;
          }
          new FlxTimer().start(0.9, 1, function():void { go() });
        }
      });
    }

    public override function update():void {
    }
  }
}
