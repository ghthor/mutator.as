package wcl
{
	
	/**
	 * ...
	 * @author ...
	 */
	public dynamic class FilteredArray extends Array 
	{
		private var filterFunc:Function;
		public function FilteredArray(p_filterFunc:Function):void {
			filterFunc = p_filterFunc;
			super();
		}
		
		override AS3 function push(...rest):uint 
		{
			var filteredArray:Array = rest.filter(filterFunc);
			for (var i:int = 0; i < filteredArray.length; i++) {
				super.push(filteredArray[i]);				
			}
			return length;
			//return super.push(rest.filter(filterFunc));
		}
		
		override AS3 function unshift(...rest):uint 
		{
			var filteredArray:Array = rest.filter(filterFunc);
			for (var i:int = 0; i < filteredArray.length; i++) {
				super.push(filteredArray[i]);
			}
			return length;
		}
	}
	
}