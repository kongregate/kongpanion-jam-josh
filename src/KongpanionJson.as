package
{

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

[Event(name="complete", type="flash.events.Event")]
public class KongpanionJson extends EventDispatcher
{
	private var _loaded : Boolean;
	private var _allKongpanionData : Object;
	private var _userKongpanionData : Object;
	private var _kongpanionDatas : Vector.<KongpanionData>;
	
	public function KongpanionJson()
	{
		_loaded = false;
	}
	
	public function load( a_username : String ) : void
	{
		var request : URLRequest = new URLRequest(
			"http://api.kongregate.com/api/kongpanions.json?username=" + a_username );
		var loader : URLLoader = new URLLoader();
		loader.addEventListener( Event.COMPLETE, onLoadComplete );
		loader.load( request );
	}
	
	private function onLoadComplete( a_event : Event ) : void
	{
		var loader : URLLoader = a_event.currentTarget as URLLoader;
		loader.removeEventListener( Event.COMPLETE, onLoadComplete );
		
		_userKongpanionData = JSON.parse( loader.data );
		
		var request : URLRequest = new URLRequest( "http://api.kongregate.com/api/kongpanions/index" );
		loader = new URLLoader();
		loader.addEventListener( Event.COMPLETE, onAllKongpanionLoadComplete );
		loader.load( request );
	}
	
	private function onAllKongpanionLoadComplete( a_event : Event ) : void
	{
		var loader : URLLoader = a_event.currentTarget as URLLoader;
		loader.removeEventListener( Event.COMPLETE, onLoadComplete );
		
		_allKongpanionData = JSON.parse( loader.data );
		
		parseJsonData( _allKongpanionData, _userKongpanionData );
		
		_allKongpanionData = null;
		_userKongpanionData = null;
	}
	
	public function parseJsonData( a_allData : Object, a_userData : Object ) : void
	{
		_kongpanionDatas = new <KongpanionData>[];
		for( var i : int = 0; i < a_allData.kongpanions.length; i++ )
		{
			var allKongpanion : Object = a_allData.kongpanions[ i ];
			
			for( var j : int = 0; j < a_userData.kongpanions.length; j++ )
			{
				var userKongpanion : Object = a_userData.kongpanions[ j ];
				if( userKongpanion.name != allKongpanion.name ) continue;
				
				allKongpanion[ "shiny" ] = userKongpanion.shiny;
				allKongpanion[ "owned" ] = true;
			}
			
			var kd : KongpanionData = new KongpanionData( allKongpanion );
			_kongpanionDatas.push( kd );
		}
		
		_kongpanionDatas.sort( sortOnId );
		
		_loaded = true;
		this.dispatchEvent( new Event( Event.COMPLETE ) );
	}
	
	private function sortOnId( a : KongpanionData, b : KongpanionData ) : Number
	{
		if( a.id < b.id ) return -1;
		else if( b.id < a.id ) return 1;
		return 0;
	}
	
	public function get loaded() : Boolean { return _loaded; }
	public function get kongpanionDatas() : Vector.<KongpanionData> { return _kongpanionDatas; }
}

}
