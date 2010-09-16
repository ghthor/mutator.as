package wcl.animation
{
	import flash.events.Event
	
	public class AnimationEvent extends Event
	{
		public static const BEGIN:String = "AnimationBegin";
		public static const PAUSE:String = "AnimationPause";
		public static const LOOP_COMPLETE:String = "AnimationLoopComp"
		public static const END:String = "AnimationEnd";
		
		public function AnimationEvent(p_name:String):void{
			super(p_name);
		}
	}
}