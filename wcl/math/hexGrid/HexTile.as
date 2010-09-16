package wcl.math.hexGrid
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import wcl.FilteredArray;
	
	/**
	 * ...
	 * @author ...
	 */
	
	/// Represents the Most Basic HexTile
	public class HexTile extends MovieClip 
	{
		/// Global Static Access to the HexGrid From HexTile
		/// Kinda Useless, I don't remember
		public static var hexGrid:HexGrid;
		
		/// Location in the HexGrid.tiles Array
		public var gridX:int;
		public var gridY:int;
		
		/// Maybe, Privatise and Wrap with a Function that Takes a Direction and Returns the Neighbor
		public var neighbors:Array;
		
		public static var hexHeight:Number = 0;
		public static var hexWidth:Number = 0;
		
		//public function HexTile(p_gridY:int, p_gridX:int, p_hexGrid:HexGrid):void {
		public function HexTile(p_gridY:int, p_gridX:int):void {
			stop();
			gridX = p_gridX;
			gridY = p_gridY;
			
			hexGrid = HexGrid.theGrid;			
		}
		
		
		/// Sets up the neighbors Array
		public function initialize():void {
			neighbors = getNeighbors();
		}
		
		/// I don't know if this is Ever Used, uh don't know what it was for
		public function clone(hexTile:HexTile = null):HexTile {
			if (hexTile == null) {
				hexTile = new HexTile(gridY, gridX);
			}
			hexTile.gridY = gridY;
			hexTile.gridX = gridX;
			
			return hexTile;
		}
		
		//public radialTiles(p_radius);
		
		/// REWRITE
		/// Recursive   REWRITE
		//public function getRadialArray(p_radius:int, p_filterFunc:Function, p_array:Array = null):Array {
		/// Recursive   REWRITE
		public function getRadialArray(p_radius:int = 1):Array {
			
			var returnArray:Array;
			
			// Proper Use of the Direction Iterator
			var dirIter:DirectionIteratorCCW = DirectionIteratorCCW.defualt();
			var tempDir:Direction;
			
			
			/*var i:Direction;
			var i:int;
			var alongEdge:Direction;
			var distanceFromTempTile:int;		
			
			var tempTile:HexTile;		
			
			
			// First Level Recursive Call Creates the Array, Subsequent Recursive calls use that Array
			if (p_array == null) {
				returnArray = new Array(p_filterFunc);
				for (i = 0; i < p_radius; i++) {
					returnArray[i] = new FilteredArray(p_filterFunc);
				}
			}else {
				returnArray = p_array;
			}		
			
			// Iterate Through the Six Directions
			for (i = Direction.East; i.hasCompletedLoopCCW(Direction.East, i); i = i.counterClockwise()) {   			// so i represents the Cardinal Direction
				tempTile = getTileByDirection(i, p_radius);		// Add tile in direction i, distance p_radius away
				//returnArray.push(tempTile);
				alongEdge = i.counterClockwise(2);		// Transform the Direction CCW 2 Ticks, This Direction points Along the Edge of the Radius
				for (distanceFromTempTile = 0; distanceFromTempTile < p_radius; distanceFromTempTile++) {				// Iterate Along the Edge and Add the Tiles to the Array, 
					returnArray[p_radius - 1].push( tempTile.getTileByDirection( alongEdge, distanceFromTempTile ) );
				}
			}
			p_radius--;
			if (p_radius > 0) {
				returnArray = getRadialArray(p_radius, p_filterFunc, returnArray);
			}*/
			return returnArray;
		}
		
		public function getTileByVector(hexVector:HexVector):HexTile {
			return getTileByDirection(hexVector.direction, hexVector.magnitude);
		}
		
		/// Returns a Tile distance away from this in direction
		public function getTileByDirection(direction:Direction, distance:int = 1):HexTile {
			// if distance 0 is Passed just return the this Tile
			if (distance == 0) {
				return this;
			}
			//trace("getTileByDirection: " + direction);
			return hexGrid.getTileAt(gridY + (distance * direction.yOffset), gridX + ( distance * direction.xOffset));
		}
		
		/// Returns an Array with all Neighbors of this tile including EdgeTiles/NullTiles
		/// Privatise this Function, it has no Use with the neighbors Array as a Property
		/// as the neighbors will never change, there is no need to procedually generate this array
		public function getNeighbors():Array {
			var rArray:Array = new Array();	
			// Proper Use of the Direction Iterator
			var dirIter:DirectionIteratorCCW = DirectionIteratorCCW.defualt();
			var tempDir:Direction;			
			for (tempDir = dirIter.begin; !(dirIter.hasCompleted()); tempDir = dirIter.next()) {
				rArray[tempDir.toIndex] = getNeighborTile(tempDir);
			}
			return rArray;
		}
		
		/// Wraps getTileByDirection for distance = 1
		public function getNeighborTile(direction:Direction):HexTile {
			return getTileByDirection(direction);
		}
		
		/// CompleteMe
		public function directionTo(hexTile:HexTile):Direction {
			return Direction.East;
		}
		
		/// CompleteMe
		public function distanceTo(hexTile:HexTile):int {
			return 0;
		}
		
		/// CompleteMe
		public function pathsTo(destination:HexTile, paths:Array = null):Array {
			return new Array();
		}
		
		override public function toString():String {
			return (" y[" + gridY + "] x[" + gridX + "]");
		}
	}
}