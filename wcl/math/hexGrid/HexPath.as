package wcl.math.hexGrid {
	
	/**
	 * ...
	 * @author ...
	 */
	public class HexPath {
		public var vectors:Array = new Array();
		private var _currentIndex:int;		
		public function get currentIndex():int { return _currentIndex; }
		private var _length:int = 0;
		
		public function get length(): { return _length; }
		
		public function HexPath(hexPath:HexPath = null):void {
			
			if (hexPath != null) {
				currentIndex = hexPath.currentIndex;
				for (var i:int = 0; i < hexPath.vectors.length; i++) {
					add(hexPath.vectors[i]);
				}
			}
		}
		
		public function copy():HexPath {
			var hexPath:HexPath = new HexPath(this);
			return hexPath;
		}
		
		public function next():HexVector {
			return new HexVector(Direction.East, 1);
		}
		
		public function prev():HexVector {
			return new HexVector(Direction.East, 1);
		}
		
		public function add(hexVector:HexVector):void {
			
			_length += hexVector.magnitude;
			vectors.push(hexVector);
		}
		
		
		
		public function applyToTile(hexTile:HexTile):Array {
			for (var i:int = 0; i < vectors.length; i++) {
				hexTile = vectors[i].applyToTile(hexTile);
			}
		}
	}
	
}