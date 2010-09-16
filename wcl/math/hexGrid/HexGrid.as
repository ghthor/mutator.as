package wcl.math.hexGrid
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	
	/// Represents the Most Basic HexGrid
	public class HexGrid extends MovieClip 
	{
		/// Global Static Access to the HexGrid
		public static var theGrid:HexGrid;
		/// Array of Tiles, Might move this to a Even More General Subclass called Grid
		public var tiles:Array = new Array();
		
		public var _sideLength:int = 6;		
		
		public function HexGrid() {
			stop();
			
			theGrid = this;
		}	
		
		/// Places the Tiles into the MovieClip accordingly And Runs the Tiles Initializer Function
		public function placeTiles():void {
			
			/// Inital Y Coord is Half the HexTile Height, Center Registration Point
			var YValue:Number = HexTile.hexHeight / 2;
			
			var i:int;
			var j:int;
			
			var tempTile:HexTile;
			
			/// this For Loop Sets the Y and X Coords of each HexTile in tiles and Adds to this Display List
			for (i = 0; i < tiles.length; i++) {				
				for (j = tiles[i].headIndex; j < tiles[i].length; j++) {
					if (i == 0 && j == 0) {  //Keystone Tile top left
						tiles[i][j].x = ((_sideLength) / 2) * HexTile.hexWidth;
						tiles[i][j].y = YValue;
						addChild(tiles[i][j]);
						continue;
					}
					tempTile = tiles[i][j];
					if (j == tiles[i].headIndex) { // Identifies the First Tile in each Row
						//trace("Placing First Col Tile [" + i + "][" + j + "]");
						tempTile.x = tiles[i - 1][j].x - HexTile.hexWidth / 2;
						tempTile.y = YValue;
					}else {
						//trace("Placing [" + i + "][" + j + "]");
						tempTile.x = tiles[i][j - 1].x + HexTile.hexWidth;
						tempTile.y = YValue;
					}
					
					addChild(tempTile);
				}
				YValue += (.75 * HexTile.hexHeight);
			}
			
			/// Initialize all the tiles
			for (i = 0; i < tiles.length; i++) {				
				for (j = tiles[i].headIndex; j < tiles[i].length; j++) {
					tempTile = tiles[i][j];
					//trace("Initializing [" + i + "][" + j + "]");
					tempTile.initialize();
				}
			}
			
		}		
		
		/// Returns a NullTile if the Passed Index is Outside of the Board Range, Override/Write a Wrapper in Subclassing for Exclusion of HexEdgeTiles as Valid Tiles
		public function getTileAt(p_gridY:int, p_gridX:int):HexTile 
		{
			var rVal:HexTile;			
			/// if passed Y Coord is inside of the valid Y values
			if (p_gridY >= 0 && p_gridY < tiles.length) {
				var tempHexRow:HexGridArray = tiles[p_gridY];
				/// if passed X Coord is inside of the valid X Values for this Row
				if (p_gridX >= tempHexRow.headIndex && p_gridX < tempHexRow.length) {
					/// Valid Array Index, Returning the occupying Tile
					rVal = tiles[p_gridY][p_gridX];
					return rVal;
				}
			}
			/// Invalid Y value Passed and x Value Passed Returning a NullTile
			rVal = new NullTile(p_gridY, p_gridX);
					
			return rVal;
		}	
		
		/// Obfuscates the sidelength since the board side is 1 unit less then the internal Array 
		public function get sideLength():int { return (_sideLength - 1); }		
		public function set sideLength(value:int):void {			
			_sideLength = value + 1;
			
		}
	}
	
}