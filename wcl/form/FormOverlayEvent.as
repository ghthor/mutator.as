package wcl.form
{
	import flash.events.Event;
	
	public class FormOverlayEvent extends Event
	{
		public var form:int;
		public var alpha:Number;
		public var color:uint;
		
		public static const OVERLAY:String = "formOverlay";
		public static const OVERLAY_FINISHED:String = "formOverlayFinished";
		
		public function FormOverlayEvent(p_name:String, p_form:int, p_color:uint = 0x000000, p_alpha:Number = .5):void{
			super(p_name);
			form = p_form;
			color = p_color;
			alpha = p_alpha;
		}
	}
}