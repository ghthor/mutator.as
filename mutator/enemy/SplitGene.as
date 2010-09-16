package mutator.enemy {
	import mutator.enemy.Gene;
	import mutator.enemy.EnemyShip;
	import wcl.math.RandomFloat;
	import wcl.randomization.Weight;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SplitGene implements Gene {
		public static const type:String = "Split"
		
		public static var poolWeight:Weight = new Weight(1, type)
		
		public static const MUTATE_DELTA_MIN:Number = -2
		public static const MUTATE_DELTA:Number = 5
		
		/* INTERFACE mutator.enemy.Gene */
		
		private var alreadySplit:Boolean = false
		var chanceToSplit:Number = RandomFloat.within(0,10)
		
		public function enter(enemy:EnemyShip):void {
			alreadySplit = false
		}
		
		public function exit(enemy:EnemyShip):void {
			alreadySplit = false
		}
		
		public function executeOn(enemy:EnemyShip):void {
			if (!alreadySplit) {
				if (RandomFloat.within(0,100) <= chanceToSplit) {
					//trace("Spliting")
					enemy.split()
				}
				alreadySplit = true
			}
		}
		
		public function clone():Gene {
			return new SplitGene()
		}
		
		public function mutate():void {
			// Can mutate out of MIN/MAX values
			// This is intended behavior
			chanceToSplit += RandomFloat.within(MUTATE_DELTA_MIN, MUTATE_DELTA)
		}
		
	}
	
}