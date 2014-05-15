package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.geom.Rectangle;

  public class KongpanionGroup extends FlxGroup
  {
    public var kongpanion:KongpanionSprite;
    public var shadow:FlxSprite;

    private var sinRate:Number = 0.6;
    private var sinAmt:Number = 0;
    private var floatAmt:Number = 5;

    public var baseOffset:Number = 0;

    public function KongpanionGroup(kongpanionData:KongpanionData, flat:Boolean=false) {
      shadow = new FlxSprite();
      shadow.loadGraphic(Assets.Shadow);
      shadow.offset.y = -18;
      add(shadow);

      kongpanion = new KongpanionSprite(kongpanionData, flat);
      add(kongpanion);
    }

    override public function update():void {
      super.update();
      sinAmt += FlxG.elapsed / sinRate;
      kongpanion.offset.y = baseOffset + (Math.sin(sinAmt) * floatAmt);
      shadow.x = kongpanion.x;
      shadow.y = kongpanion.y;
      shadow.alpha = kongpanion.alpha;
    }

    public function setScale(x:Number, y:Number):void {
      shadow.scale.x = kongpanion.scale.x = x;
      shadow.scale.y = kongpanion.scale.y = y;
    }
  }
}
