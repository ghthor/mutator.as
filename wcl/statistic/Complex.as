package wcl.statistic
{
	import wcl.math.RandomFloat;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Complex
	{
		public var _min:Number;	
		public var _max:Number;		
		public var _cur:Number;	
		
		public function Complex(min_:Number = 0, max_:Number = 0, cur_:Number = 0):void {
			_min = min_
			_max = max_
			_cur = cur_
		}
		
		public static function clone(c:Complex, r:Complex = null):Complex {
			if (r == null) {
				r = new Complex();
			}
			r._min = c._min;
			r._max = c._max;
			r._cur = c._cur;
			return r;
		}
		
		public function get range():Number {
			return max - min;
		}
		
		public function get min():Number { return _min; }		
		public function set min(value:Number):void {
			_min = value;
			if (_cur < _min) {
				_cur = _min
			}
		}
		
		public function get max():Number { return _max; }		
		public function set max(value:Number):void {
			_max = value;
			if (_cur > _max) {
				_cur = _max
			}
		}
		
		public function get cur():Number { return _cur; }		
		public function set cur(value:Number):void {
			if (value <= _min) {
				_cur = _min
			} else if ( value >= _max) {
				_cur = _max
			} else {
				_cur = value
			}
		}
		
		// takes to randoms and sets the smaller to min and the larger to max
		// after that also sets cur to max
		public function setMinMaxWithRandoms(rand1:Number, rand2:Number) {
			_min = Math.min(rand1, rand2)
			_max = Math.max(rand1, rand2)
			_cur = _max
		}
		
		public function setToMax() {
			_cur = _max
		}
		
		public function setToMin() {
			_cur = _min
		}
		
		public function randomWithin() {
			return RandomFloat.within(min, max)
		}
		
		public function setCurrentToRandom() {
			cur = randomWithin()
		}
		
		public function get isMin():Boolean {
			return (min == cur)
		}
		
		public function get isMax():Boolean {
			return (max == cur)
		}
		
		public function toString():String {
			var str:String = "Statistic [" + min + ":" + max + "] range: " + range + " cur: " + cur
			if (isMax) {
				str += " Max"
			} else if (isMin) {
				str += " Min"
			}
			return str
		}
	}	
}