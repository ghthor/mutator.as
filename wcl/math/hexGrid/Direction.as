package wcl.math.hexGrid
{
	
	/**
	 * ::TODO::
	 * Rewrite to Be more General and then Subclass For each Grid Type
	 * @author ...
	 */
	public class Direction
	{
		/// Verbosities Sake
		private static const EAST:uint 						= 0;
		private static const NORTHEAST:uint 				= 1;
		private static const NORTHWEST:uint 				= 2;
		private static const WEST:uint 						= 3;
		private static const SOUTHWEST:uint 				= 4;
		private static const SOUTHEAST:uint 				= 5;		
		private static const COMPLETED:uint	 				= 6;		
		
		
		/// These Static Var's Are what are Used By Everything Else
		public static var East:Direction;
		public static var Northeast:Direction;
		public static var Northwest:Direction;
		public static var West:Direction;
		public static var Southwest:Direction;
		public static var Southeast:Direction;
		
		/// Internal Array of Static Directions
		private static var _directions:Array = new Array();
		
		private var _direction:uint;
		private var _name:String;		
		private var _yOffset:int;
		private var _xOffset:int;		
		
		private var _isEndpoint:Boolean;
		
		private var _clockwise:Direction;
		private var _counterClockwise:Direction;
		
		public function Direction(p_direction:int, p_name:String, p_yOffset:int, p_xOffset:int, p_isEndpoint:Boolean = false):void {
			_direction = p_direction;
			_directions[_direction] = this;
			_name = p_name;
			
			_yOffset = p_yOffset;
			_xOffset = p_xOffset;
			
			_isEndpoint = p_isEndpoint;			
			
			/// Last Direction Created, initialize them all
			if (_isEndpoint) {
				var i:int = 0;
				link(_directions[i], this); // Link East(0) to Southeast(5)
				
				// Link the Rest
				for (i = 1; i < _directions.length; i++) {
					link(_directions[i], _directions[i - 1]);
				}
			}			
			
		}
		
		/// Internal Function
		private function link(dir:Direction, cwDir:Direction):void {
			dir._clockwise = cwDir;
			cwDir._counterClockwise = dir;
		}
		
		/// HexGrid Specific
		public static function initializeHexGrid():void {
			East		= new Direction(EAST,"East",0,1);
			Northeast 	= new Direction(NORTHEAST,"Northeast",-1,0);
			Northwest 	= new Direction(NORTHWEST,"Northwest",-1,-1);
			West		= new Direction(WEST,"West",0,-1);
			Southwest 	= new Direction(SOUTHWEST,"Southwest",1,0);
			Southeast	= new Direction(SOUTHEAST,"SouthEast",1,1,true);
		}
		
		/// HexGrid Specific
		/// Transfrom Direction by 180 deg
		public function opposingDirection():Direction {
			return clockwise(3);
		}
		
		/// Recursive
		public function clockwise(nTimes:uint = 1):Direction {
			nTimes--;
			if (nTimes == 0) {
				return _clockwise;
			}else {
				return _clockwise.clockwise(nTimes);
			}
		}
		
		/// Recursive
		public function counterClockwise(nTimes:uint = 1):Direction {
			nTimes--;
			if (nTimes == 0) {
				return _counterClockwise;
			}else {
				return _counterClockwise.counterClockwise(nTimes);
			}
		}
		
		/// HexGrid Specific
		public function createRadialIterateArrayCCW(p_radius:uint = 1):Array {
			var rArray:Array = new Array();
			var direction:Direction = this;
			for (var i:int = 0; i < _directions.length; i++) {
				for (var j:int = 0; j < p_radius; j++) {
					rArray.push(direction);
				}
				direction = direction.counterClockwise();
			}
			trace("Radial Array of Directions Created with Direction");
			trace("Array: " + rArray);
			return rArray;
		}
		
		public function toString():String {
			return ("Direction: " + _name + " yOff[" + yOffset + " xOff[" + xOffset);
		}
		
		public function get length():uint			{ return _directions.length; }
		public function get toIndex():int 			{ return _direction; }		
		public function get direction():int 		{ return _direction; }
		//public function toString():String 			{ return _name; }
		public function get xOffset():int 			{ return _xOffset; }		
		public function get yOffset():int 			{ return _yOffset; }
		public function get isEndpoint():Boolean 	{ return _isEndpoint; }
		
	}
	
}