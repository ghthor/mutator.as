﻿package wcl.math {
	
	/**
	 * ...
	 * @author ...
	 */
	public class RandomFloat
	{
		
		public var min:Number = 0
		public var max:Number = 1.0
		
		public function RandomFloat(min_:Number = 0, max_:Number = 1.0):void {
			min = min_
			max = max_
		}
		
		public function range():Number {
			return (max - min)
		}
		
		public function next():Number {
			var r:Number = Math.random()
			r = r * range()
			r += min
			return r
		}		
	}
	
}