package
{
  import org.flixel.*;
  import org.flixel.plugin.photonstorm.*;
  import flash.events.*;

  import com.greensock.*;
  import com.greensock.loading.*;
  import com.greensock.events.LoaderEvent;
  import com.greensock.loading.display.*;

  public class MenuState extends FlxState
  {
    [Embed(source = '../data/Arvo.ttf', fontFamily="zerofour", embedAsCFF="false")] public var ZeroFour:String;

    private var canStart:Boolean = false;
    private var username:String = "schonstal";

    private var loadingText:FlxText;
    
    override public function create():void {
      super.create();
      loadKongpanionJson();

      loadingText = new FlxText(0, FlxG.height/2 - 8, FlxG.width);
      loadingText.alignment = "center";
      loadingText.font = "zerofour";
      loadingText.size = 16;
      add(loadingText);
    }

    override public function update():void {
      if(canStart) {
        loadingText.text = "CLICK TO BEGIN.";
        if(FlxG.mouse.justPressed()) FlxG.switchState(new PlayState());
      } else {
        loadingText.text = "LOADING KONGPANION DATA FROM KONGREGATE..."
      }
      super.update();
    }

    private function loadKongpanionJson():void {
      var kj:KongpanionJson = new KongpanionJson();
      kj.addEventListener(Event.COMPLETE, onKongpanionJsonLoadComplete);
    
      if (KongpanionJsonFixtures.USE_FIXTURES) {
        kj.parseJsonData(KongpanionJsonFixtures.BASIC, KongpanionJsonFixtures.USER);
      } else {
        kj.load(username);
      }
    }

    private function onKongpanionJsonLoadComplete(a_event:Event):void {
      var kj:KongpanionJson = a_event.currentTarget as KongpanionJson;
      G.kongpanionDatas = kj.kongpanionDatas;
      
      var queue:LoaderMax = new LoaderMax({onComplete: onKongpanionIconsLoaded});
      for (var i : int = 0; i < G.kongpanionDatas.length; i++) {
        var kd:KongpanionData = G.kongpanionDatas[i];
        queue.append(new ImageLoader(kd.iconUrl, {name: kd.name}));
      }
      queue.load();
    }
    
    private function onKongpanionIconsLoaded(a_event:LoaderEvent):void {
      canStart = true;
    }
  }
}
