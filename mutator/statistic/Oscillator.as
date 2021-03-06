package mutator.statistic
{
	import mutator.Mutatable;
	import mutator.Ticker;
	import wcl.math.RandomBool;
	import wcl.statistic.Complex;
	
	/**
	 * ...
	 * @author Will Walthall
	 */
	public class Oscillator extends Complex //implements Mutatable, Ticker
	{
		public var _period:Number
		public var _direction:Boolean
		public var _start:Number
		
		public static function clone(c:Oscillator, r:Oscillator = null):Oscillator {
			if (r == null) {
				r = new Oscillator()
			}
			Complex.clone(c, r)
			r._period = c._period
			r._direction = c._direction
			r.start = c._start
			return r
		}
		
		public static function RandomOscillationDirection():Boolean {
			return RandomBool.next()
		}	
		
		public function Oscillator():void {
			super()
		}
		
		public function get start():Number { return _start; }		
		public function set start(value:Number):void {
			_start = value;
			if (value <= min) {
				_start = min
			} else if (value >= max) {
				_start = max
			}
			cur = start
		}
		
		public function get direction():Boolean { return _direction; }
		
		public static const TOWARDS_MAX:Boolean = true
		public static const TOWARDS_MIN:Boolean = false		
		
		public function get period():Number { return _period; }
		public function set period(value:Number):void {
			_period = value
		}
		
		// I have no idea if these are correct, need to look it up in a physics textbook
		public function get frequency():Number {
			if (_period == 0) {
				return 0
			}
			return 1 / _period
		}
		public function set frequency(value:Number):void {
			if (value != 0) {
				_period = 1 / value
			} else {
				_period = 0
			}
		}
		
		// All ticks should be able to take a Number Param with range [-1,1] signifying reversing an action
		public function tick(percent:Number) {
			if (min == max) {
				return;
			}
			if (_direction == TOWARDS_MAX) {
				tickPos(percent)
			} else {
				tickNeg(percent)
			}
		}
		
		private function tickNeg(percent:Number) {
			cur -= (range / period / 2) * percent
			if (cur <= min) {
				_direction = !_direction
			}
		}
		
		private function tickPos(percent:Number) {
			cur += (range / period / 2) * percent
			if (cur >= max) {
				_direction = !_direction
			}
		}
		
		public function setStartAndDirection(start_:Number, direction_:Boolean) {
			start = start_
			_direction = direction_
		}
		
		public function randomStartAndDirection():void {
			start = randomWithin()
			_direction = RandomBool.next()
		}
		
		public function mutate() {
			
		}
	}	
}