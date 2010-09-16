package wcl.math.hexGrid {
	import wcl.math.hexGrid.Direction;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DirectionIteratorCW extends DirectionIterator {
		
		public function DirectionIteratorCW(p_begin:Direction, p_end:Direction, p_nTimes:uint = 1):void {			
			super(p_begin, p_end, p_nTimes);
		}
		
		override public function next():Direction {
			current = current.clockwise();
			if (current == end) {
				nTimes--;
			}
			return super.next();
		}
		
		override public function prev():Direction {
			return current.counterClockwise();
		}
	}
	
}