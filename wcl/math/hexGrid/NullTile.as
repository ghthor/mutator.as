package wcl.math.hexGrid
{	
	/**
	 * ...
	 * @author ...
	 */
	/// Represents a Tile that Doesn't Exist in the Board Array But can Still be Used to Direction and Chunking Algorithms
	public class  NullTile extends HexTile
	{
		public function NullTile(p_gridY:int, p_gridX:int):void{
			super(p_gridY, p_gridX);			
		}
	}
	
}