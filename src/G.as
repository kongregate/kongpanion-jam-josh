package
{
    import org.flixel.*;

    public class G
    {
        public var _game:FlxGame;

        private static var _instance:G;
        private var _hueShift:Number;
        private var _kongpanionDatas:Vector.<KongpanionData>;
        private var _shuffledKongpanionDatas:Array;
        private var _kongpanionIndex:int;

        public function G() {
        }

        private static function get instance():G {
            if(_instance == null) {
                _instance = new G();
                _instance._hueShift = 0;
            }

            return _instance;
        }

        public static function get hueShift():Number {
          return instance._hueShift;
        }

        public static function set hueShift(value:Number):void {
          instance._hueShift = value;
        }

        public static function get kongpanionIndex():int {
          return instance._kongpanionIndex;
        }

        public static function set kongpanionIndex(value:int):void {
          instance._kongpanionIndex = value;
        }
  
        public static function get kongpanionDatas():Vector.<KongpanionData> {
          return instance._kongpanionDatas;
        }

        public static function set kongpanionDatas(value:Vector.<KongpanionData>):void {
          instance._kongpanionDatas = value;
        }

        public static function get shuffledKongpanionDatas():Array {
          return instance._shuffledKongpanionDatas;
        }

        public static function shuffle():void {
          instance._shuffledKongpanionDatas = new Array();

          for (var i:int=0; i < instance._kongpanionDatas.length; i++) {
            if(i != instance._kongpanionIndex) {
              instance._shuffledKongpanionDatas.push(instance._kongpanionDatas[i]);
            }
          }

          FlxU.shuffle(instance._shuffledKongpanionDatas,
                       instance._shuffledKongpanionDatas.length * 4);
        }
    }
}
