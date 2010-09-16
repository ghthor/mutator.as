package wcl {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ...
	 * This Class Is used for loading data from files, initally is going to support only XML files
	 */
	public class DataManager extends EventDispatcher{
		public var loader:URLLoader = new URLLoader();
		
		public function loadFile(filename:String):void {
			loader.load(new URLRequest(filename));
			
			/// Event Listeners
			loader.addEventListener(Event.COMPLETE, complete);			
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
		}
		
		/// Called when the file is Completely Loaded
		public function complete(e:Event):void {
			dispatchEvent(e);
			loader.removeEventListener(Event.COMPLETE, complete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loadError);			
		}
		
		/// Error Handler
		function loadError(e:IOErrorEvent):void {
			trace("Error reading the data file. The server may be busy. Try refreshing the page.");
		}
	
	}
	
}