package wcl.math.hexGrid {
	
	/**
	 * ...
	 * @author ...
	 */
	public class DirectionIterator {
		public var dir:Direction;			// Current Position
		public var begin:Direction;			// First Item used for Iteration
		public var end:Direction;			// Last Item used for Iteration
		public var nTimes:uint;				// Times to Cycle through the Iteration
		
		public function DirectionIterator(p_begin:Direction, p_end:Direction, p_nTimes:uint = 1):void {
			dir = begin = p_begin;
			end = p_end;
			nTimes = p_nTimes;
		}
		
		public function next():Direction {
			return dir;
		}
		
		public function prev():Direction {
			return dir;
		}
		
		public function hasCompleted():Boolean {
			return((nTimes == 0) && (prev() == end));
		}
		
		public function reset(p_nTimes:uint = 1):void {
			dir = begin;
			nTimes = p_nTimes;
		}
	}
	
}