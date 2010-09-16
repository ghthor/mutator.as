package wcl.animation
{
	import flash.events.Event;
	
	import flash.display.MovieClip;
	
	var tacos:Animation.Animation
	
	public class Animation extends MovieClip
	{
		public var maxLoops:int = 1;
		private var loopCounter:int = 0;
	
		public function Animation()
		{
			stop();
		}
		
		// Fires BEGIN
		public function playXTimes(p_times:int):void
		{
			maxLoops = p_times;
			loopCounter = 0;
			gotoAndStop(1);
			play();
			dispatchEvent(new AnimationEvent(AnimationEvent.BEGIN));
		}

		public override function play():void
		{
			if(!hasEventListener(Event.ENTER_FRAME))
			{
				addEventListener(Event.ENTER_FRAME, checkForEnd);
			}
			super.play();
			
		}
		
		// Fires PAUSE
		public override function stop():void
		{
			if(hasEventListener(Event.ENTER_FRAME))
			{
				removeEventListener(Event.ENTER_FRAME, checkForEnd);
			}
			super.stop();
			dispatchEvent(new AnimationEvent(AnimationEvent.PAUSE));
			
		}
		
		// Fires LOOP_COMPLETE every Loop Completion and END after maxLoops is met
		function checkForEnd(e:Event):void
		{
			if(currentFrame == totalFrames)
			{
				loopCounter++;
				dispatchEvent(new AnimationEvent(AnimationEvent.LOOP_COMPLETE));
				if(loopCounter == maxLoops)
				{
					stop();
					removeEventListener(Event.ENTER_FRAME, checkForEnd);
					dispatchEvent(new AnimationEvent(AnimationEvent.END));
					loopCounter = 0;
				}
			}
		}
		
	}
}