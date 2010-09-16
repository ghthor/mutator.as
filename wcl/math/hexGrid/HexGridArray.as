package wcl.math.hexGrid
{
	
	/**
	 * ...
	 * @author ...
	 */
	
	///[y]
	///[0]   0 1 2 3
	///[1]  0 1 2 3 4
	///[2]   1 2 3 4  <-----This is the Case I have to Worry About
	/// This Class has to Be Used For the x Row of the Grid Array
	public dynamic class HexGridArray extends Array 
	{
		
		public function HexGridArray():void {
		}
		
		/// Stores the Begining Index of the x Row
		private var _headIndex:int;
		public function get headIndex():int { return _headIndex; }		
		public function set headIndex(value:int):void {
			_headIndex = value;
		}
		
		/// Calculate the Number of Tiles in this x Row
		public function tileCount():uint {
			var rVal:uint = length - headIndex;			
			return rVal;
		}
	}
	
}