package
{
	import flash.display.Loader;
	import flash.net.URLRequest;

public class KongpanionData
{
	private var _name : String;
	private var _id : int;
	private var _description : String;
	private var _tags : Vector.<String>;
	private var _shiny : Boolean;
	private var _owned : Boolean;
	private var _normalIconUrl : String;
	private var _shinyIconUrl : String;
	
	public function KongpanionData( a_data : Object )
	{
		_name = a_data.name;
		_id = a_data.id;
		_description = a_data.description;
		_tags = Vector.<String>( a_data.tags );
		_shiny = a_data.shiny;
		_owned = a_data.owned;
		_normalIconUrl = a_data.normal_icon_url;
		_shinyIconUrl = a_data.shiny_icon_url;
	}
	
	public function getIcon( a_autoLoad : Boolean = true ) : Loader
	{
		var icon : String = _shiny ? _shinyIconUrl : _normalIconUrl;
		var request : URLRequest = new URLRequest( icon );
		
		var loader : Loader = new Loader();
		
		if ( a_autoLoad )
		{
			loader.load( request );
		}
		
		return loader;
	}
	
	public function get name() : String { return _name; }
	public function get id() : int { return _id; }
	public function get description() : String { return _description; }
	public function get tags() : Vector.<String> { return _tags; }
	public function get isShiny() : Boolean { return _shiny; }
	public function get isOwned() : Boolean { return _owned; }
	public function get iconUrl() : String { return _shiny? _shinyIconUrl : _normalIconUrl; }
	public function get normalIconUrl() : String { return _normalIconUrl; }
	public function get shinyIconUrl() : String { return _shinyIconUrl; }
}

}
