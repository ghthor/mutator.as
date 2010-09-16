package wcl.form
{
	import flash.events.MouseEvent;
	
	public interface I_Form
	{
		function initialize():void;
		function enableAllEvents():void;
		function disableAllEvents():void;		
		//function get index():int;
		function set index(p_val:int):void;
	}
}