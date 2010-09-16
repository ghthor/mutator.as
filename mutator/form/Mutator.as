package mutator.form {
	
	import flash.events.Event;
	import wcl.Console;
	import wcl.form.*
	/**
	 * ...
	 * @author ...
	 */
	public class Mutator extends FormManager {
		
		private static var _stageWidth:Number = 0
		private static var _stageHeight:Number = 0
		
		public function Mutator() {
			addEventListener(Event.ENTER_FRAME, load)
		}
		
		public function load(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, load)
			super.initialize()
			
			_stageWidth = theStage.stageWidth
			_stageHeight = theStage.stageHeight
			
			// Add Forms to Managed Array
			Console.initialize()
			addForm(new TitleScreen())
			addForm(new GameScreen())
			addForm(new OptionsScreen())
			
			// initialize Each Form and Lock the Array from more Additions
			initializeAndLock()
		}
		
		static public function get stageWidth():Number { return _stageWidth; }
		
		static public function get stageHeight():Number { return _stageHeight; }
	}
	
}