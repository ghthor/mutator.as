package wcl.math {
	
	/**
	 * ...
	 * @author Will Walthall
	 */
	public class RandomFloat
	{
		
		public var min:Number
		public var max:Number
		
		public static function within(min_:Number, max_:Number):Number {
			var r:Number = Math.random()
			r = r * (max_ - min_)
			r += min_
			return r
		}
		
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