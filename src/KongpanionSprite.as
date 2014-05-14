package
{
  import org.flixel.*;
  import com.greensock.loading.display.ContentDisplay;
  import com.greensock.loading.LoaderMax;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.geom.Rectangle;

  public class KongpanionSprite extends FlxSprite
  {
    public var flatColor:uint;

    private var kongpanionData:KongpanionData;
    private var pixelArray:Vector.<uint>;

    public function KongpanionSprite(kData:KongpanionData) {
      super();
      kongpanionData = kData;
      var content:ContentDisplay = LoaderMax.getContent(kongpanionData.name);
		  pixels = (content.rawContent as Bitmap).bitmapData;
      flatColor = determineColor();
      //flatten();
    }

    public function determineColor():uint {
      pixelArray = pixels.getVector(new Rectangle(0,0,width,height));
      var startPixel = width*(height/2);
      while(pixelArray[startPixel] < 0xff000000) {
        startPixel++;
      }
      //makeGraphic(pixelArray[startPixel], width, height);
      return pixelArray[startPixel];
    }

    public function flatten():void {
      pixelArray = pixelArray.map(function(pixel:uint, index:int, thisObject:Vector.<uint>):uint {
        return pixel & 0xff000000 ? flatColor : 0;
      });

      var buffer:BitmapData = new BitmapData(width, height)
      buffer.setVector(new Rectangle(0,0,width,height), pixelArray);
      pixels = buffer;
    }
  }
}
