﻿package mutator.form {
	
	import flash.events.Event;
	import wcl.Console;
	import wcl.form.*
	/**
	 * ...
	 * @author ...
	 */
	public class Mutator extends FormManager {
		
		public function Mutator() {
			addEventListener(Event.ENTER_FRAME, load)
		}
		
		public function load(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, load)
			super.initialize()
			
			// Add Forms to Managed Array
			Console.initialize()
			addForm(new TitleScreen())
			addForm(new GameScreen())
			addForm(new OptionsScreen())
			
			// initialize Each Form and Lock the Array from more Additions
			initializeAndLock()
		}
	}
	
}