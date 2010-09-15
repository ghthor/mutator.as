package mutator.enemy {
	import wcl.randomization.Weight;
	import wcl.randomization.WeightedPool;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GenePool extends WeightedPool {
		private static var idCounter:uint = 0
		
		public function initialize():void {
			addAnItemToPool(MovementGene.poolWeight)
			addAnItemToPool(FollowGene.poolWeight)
			addAnItemToPool(SplitGene.poolWeight)
		}
		
		override public function addItemToPool(item:Weight):void {
			item.id = idCounter++
			super(item)
		}
		
		public static function geneFromType(type:String):Gene {
			switch(type) {
				case MovementGene.type:
					return new MovementGene()
					break
				case FollowGene.type:
					return new FollowGene()
					break
				case SplitGene.type:
					return new SplitGene()
					break
				default:
					return new MovementGene()
			}
		}
	}
	
}