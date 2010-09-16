package wcl.net {
	import com.adobe.serialization.json.JSON;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import wcl.Console;
	import wcl.json.JsonStr;
	
	/**
	 * ...
	 * @author ...
	 */
	public class JSONSocket extends Socket {
		var JSONStrSize:uint;
		var JSONObjects:Array = new Array();
		
		public function JSONSocket():void {
			super()
			addEventListener(Event.CLOSE, handleDC)
			addEventListener(Event.CONNECT, handleConnect);
			addEventListener(IOErrorEvent.IO_ERROR, handleIoError)
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecError)
			addEventListener(ProgressEvent.SOCKET_DATA, readJSON);
		}
		
		private function handleDC(e:Event):void {
			Console.writeStr("Server Disconnected")
			close()
		}
		
		private function handleSecError(e:SecurityErrorEvent):void {
			Console.writeStr(e.text)
		}
		
		private function handleIoError(e:IOErrorEvent):void {
			Console.writeStr(e.toString());
		}
		
		public function initialize():void {
			JSONStrSize = 0;
			endian = Endian.LITTLE_ENDIAN
			Console.writeStr(Security.sandboxType)
			if (Security.sandboxType == "remote") {
				Console.writeStr("Loading Policy File")
				Security.loadPolicyFile("http://server.local/crossdomain.xml")
			}
			JSONObjects.slice()
			//Security.loadPolicyFile("crossdomain.xml")
			//addEventListener(Event.CONNECT, onConnect);
			
		}
		
		public function ConnToServer():void {
			Console.writeStr("Connecting To Server")
			//connect("server.local", 56000)
			connect("192.168.9.1", 56000)
		}
		
		public function handleConnect(e:Event):void {
			Console.writeStr("Connected to Server")
			//removeEventListener(Event.CONNECT, onConnect);
			
		}
		
		public function readJSON(e:ProgressEvent):void {
			readJSONSize()
		}
		
		public function readJSONSize():void {
			if (JSONStrSize == 0) {
				if (bytesAvailable >= 4) {
					JSONStrSize = readUnsignedInt()
					//Console.writeStr("Json String Size: " + JSONStrSize)
					//trace("Json String Size: " + JSONStrSize)
					readJSONObject();
				}
			}else {
				readJSONObject();
			}
		}
		
		public function readJSONObject():void {
			//Console.writeStr("Reading Json Object bytesAvail: " + bytesAvailable + " JSONStrSize: " + JSONStrSize)
			//trace("Reading Json Object bytesAvail: " + bytesAvailable + " JSONStrSize: " + JSONStrSize)
			if (bytesAvailable >= JSONStrSize) {
				var bytes:ByteArray = new ByteArray()
				readBytes(bytes, 0, JSONStrSize)
				var JSONStr:String = bytes.readUTFBytes(JSONStrSize)
				//Console.writeStr("JSONStr: " + JSONStr)
				//trace("JSONStr: " + JSONStr)
				JSONStrSize = 0;
				JSONObjects.push(JSON.decode(JSONStr))
				if (JSONObjects.length > 0) {
					dispatchEvent(new Event("new_JSON"));
				}
				// This if is redundant
				if (bytesAvailable >= 4) {
					readJSONSize()
				}
			}
		}
		
		public function writeJSONStr(jsonStr:JsonStr):void {
			writeUnsignedInt(jsonStr.bytes.length)
			writeBytes(jsonStr.bytes)
			//flush()
		}
		
		public function popJSON():Object {
			return JSONObjects.shift();
		}
	}
	
}