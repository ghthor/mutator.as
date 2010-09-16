package wcl.math.hexGrid {
	
	/**
	 * ...
	 * @author ...
	 */
	/// This Class Holds the Data for a Magnitude + Direction
	public class HexVector {
		
		public var direction:Direction;
		public var magnitude:int;
		
		public function HexVector(p_direction:Direction, p_magnitude:int = 1):void {
			direction = p_direction;
			magnitude = p_magnitude;
		}
		
		public function applyToTile(hexTile:HexTile):HexTile {
			return hexTile.getTileByVector(this);
		}
	}
	
}