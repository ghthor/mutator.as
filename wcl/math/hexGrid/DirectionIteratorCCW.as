package wcl.math.hexGrid {
	import wcl.math.hexGrid.Direction;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DirectionIteratorCCW extends DirectionIterator {
		
		private static var freeIterators:Array = new Array();
		
		public function DirectionIteratorCCW(p_begin:Direction, p_end:Direction, p_nTimes:uint = 1):void {
			super(p_begin, p_end, p_nTimes);
		}
		
		override public function next():Direction {
			dir = dir.counterClockwise();
			if (dir == end) {
				nTimes--;
			}
			return super.next();
		}
		
		override public function prev():Direction {
			return dir.clockwise();
		}
		
		override public function hasCompleted():Boolean {
			if (super.hasCompleted()) {
				//trace("Iterator Array: " + freeIterators.push(this));
				this.reset(1);
				return true;
			}
			return false;
		}
		
		public static function defualt():DirectionIteratorCCW {
			return new DirectionIteratorCCW(Direction.East, Direction.Southeast);
		}
	}
	
}