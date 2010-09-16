package wcl.form
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
		
	public class Form extends MovieClip
	{	
		public function Form():void {
			stop();
		}
		// All Forms will Have access to this function that will return them to the previous Form
		public function goToPreviousForm(e:MouseEvent):void{
			FormManager.me.dispatchEvent(new FormSwitchEvent(FormSwitchEvent.BACK));
		}
		
		/// Wrapper Function
		public function switchToForm(formId:int):void {
			dispatchFormEvent(new FormSwitchEvent(FormSwitchEvent.SWITCH, formId));
		}
		
		public function dispatchFormEvent(e:Event):void {
			FormManager.me.dispatchEvent(e);
		}
	}
}