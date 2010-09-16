package mutator.enemy {
	import wcl.randomization.Weight;
	import wcl.randomization.WeightedPool;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GenePool extends WeightedPool {
		private static var idCounter:uint = 0
		
		public static var pool:GenePool = new GenePool()
		
		public function GenePool() {
			super()
		}
		
		public static function initialize():void {
			pool.addAnItemToPool(MovementGene.poolWeight)
			pool.addAnItemToPool(FollowGene.poolWeight)
			pool.addAnItemToPool(SplitGene.poolWeight)
			pool.addAnItemToPool(ScaleGene.poolWeight)
			
			StartAreaGene.initialize()
			DnaArray.initialize()
		}
		
		public function newDna():DnaArray {
			var dna:DnaArray = new DnaArray()
			dna.startGene = new StartAreaGene()
			for (var i:int = 0; i < EnemyShip.NUMBER_OF_GENES; i++) {
				dna.push(geneFromType(next().type))
			}
			return dna
		}
		
		override public function addAnItemToPool(item:Weight):void {
			item.id = idCounter++
			super.addAnItemToPool(item)
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
				case ScaleGene.type:
					return new ScaleGene()
					break
				default:
					return new MovementGene()
			}
		}
	}
	
}