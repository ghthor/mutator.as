package wcl.math.hexGrid {
	import flash.display.MovieClip;
	import wcl.math.hexGrid.HexTile;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HexTileSize extends MovieClip {
		
		public function HexTileSize():void {			
			if (HexTile.hexHeight == 0) {
				HexTile.hexHeight = height;
			}
			if (HexTile.hexWidth == 0) {
				HexTile.hexWidth = width;
			}
		}
	}
	
}