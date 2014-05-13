package
{
  import org.flixel.*;
  import com.greensock.loading.display.ContentDisplay;
  import com.greensock.loading.LoaderMax;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class KongpanionSprite extends FlxSprite
  {
    private var kongpanionData:KongpanionData;

    public function KongpanionSprite(kData:KongpanionData) {
      super();
      kongpanionData = kData;
      var content:ContentDisplay = LoaderMax.getContent(kongpanionData.name);
		  pixels = (content.rawContent as Bitmap).bitmapData;
    }
  }
}
