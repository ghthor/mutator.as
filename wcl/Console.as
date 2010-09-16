package wcl {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Console {
		
		public static var display:Sprite = new Sprite()
		static var lines:Array = new Array();
		static var maxLines:int = 4;
		public static function initialize():void {
			var temp:TextField;
			var i:int = 0;
			for (i = 0; i < maxLines; i++) {
				temp = new TextField()
				temp.autoSize = TextFieldAutoSize.LEFT
				temp.textColor = 0xffffff
				temp.text = "line " + i
				temp.y = -(i * temp.height)
				display.addChild(temp)
				lines[i] = temp
			}
		}
		
		public static function writeStr(s:String):void {
			for (var i:int = maxLines - 1; i > 0; i--) {
				var temp:TextField = lines[i-1]
				lines[i].text = temp.text
			}
			lines[0].text = s;
		}
		
	}
	
}