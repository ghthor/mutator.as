package wcl.randomization {
	
	/**
	 * ...
	 * @author ...
	 */
	public class ExamplePool extends WeightedPool {
		
		private static var idCounter:uint = 0
		
		public var returns:Array = new Array()
		
		public function ExamplePool() {
			// lets do a stack of cards
			addAnItemToPool(new Weight(0, "0", idCounter++))
			addAnItemToPool(new Weight(1, "1", idCounter++))
			addAnItemToPool(new Weight(2, "2", idCounter++))
			addAnItemToPool(new Weight(3, "3", idCounter++))
			addAnItemToPool(new Weight(4, "4", idCounter++))
			addAnItemToPool(new Weight(5, "5", idCounter++))
			addAnItemToPool(new Weight(20, "20", idCounter++))
		}
	}
	
}