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
					trace("Spliting")
					enemy.split()
				}
				alreadySplit = true
			}
		}
		
		public function clone():Gene {
			return new SplitGene()
		}
		
	}
	
}