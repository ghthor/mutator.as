package wcl.json {
	import com.adobe.serialization.json.JSON;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author ...
	 */
	public class JsonStr {
		public var bytes:ByteArray
		public function JsonStr(o:Object):void {
			fromObject(o)
		}
		public function fromObject(o:Object):void {
			var jsonStr:String = JSON.encode(o)
			//trace("JsonStr: " + jsonStr)
			fromString(jsonStr)
		}
		
		public function fromString(s:String) {
			bytes = new ByteArray()
			bytes.writeUTFBytes(s)
		}
	}
	
}