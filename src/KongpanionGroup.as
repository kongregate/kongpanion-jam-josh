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

    public function KongpanionGroup(kongpanionData:KongpanionData) {
      shadow = new FlxSprite();
      shadow.loadGraphic(Assets.Shadow);
      shadow.offset.y = -15;
      shadow.scale.x = shadow.scale.y = 0.5
      add(shadow);

      kongpanion = new KongpanionSprite(kongpanionData);
      kongpanion.scale.x = kongpanion.scale.y = 0.5
      add(kongpanion);
    }

    override public function update():void {
      super.update();
      sinAmt += FlxG.elapsed / sinRate;
      kongpanion.offset.y = Math.sin(sinAmt) * floatAmt;
      shadow.x = kongpanion.x;
      shadow.y = kongpanion.y;
    }
  }
}
