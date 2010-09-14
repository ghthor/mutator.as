package mutator.enemy {
	import wcl.randomization.Weight;
	import wcl.randomization.WeightedPool;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GenePool extends WeightedPool {
		private static var idCounter:uint = 0
		
		override public function addItemToPool(item:Weight):void {
			item.id = idCounter++
			super(item)
		}
		
		public static function geneFromType(type:String):Gene {
			switch(type) {
				case MovementGene.type:
					break
				default:
					return new MovementGene()
			}
		}
	}
	
}