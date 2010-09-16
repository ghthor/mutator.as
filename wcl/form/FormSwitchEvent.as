package wcl.form
{
	import flash.events.Event;
	
	public class FormSwitchEvent extends Event
	{
		public var next_id:int;
		
		public static const SWITCH:String = "formSwap";
		public static const BACK:String = "formBack";
		
		public function FormSwitchEvent(p_name:String, p_next_id:int = -1){
			super(p_name);
			next_id = p_next_id;
		}
	}
}