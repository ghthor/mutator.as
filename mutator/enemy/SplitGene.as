package mutator.enemy {
	import mutator.enemy.Gene;
	import mutator.enemy.EnemyShip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SplitGene implements Gene {
		public static const type:String = "Split"
		
		public static var poolWeight:Weight = new Weight(0, type)
		
		/* INTERFACE mutator.enemy.Gene */
		
		private var alreadySplit:Boolean = false
		
		public function enter(enemy:EnemyShip):void {
			alreadySplit = false
		}
		
		public function exit(enemy:EnemyShip):void {
			alreadySplit = false
		}
		
		public function executeOn(enemy:EnemyShip):void {
			if (!alreadySplit) {
				// enemy.Split()
				alreadySplit = true
			}
		}
		
		public function clone():Gene {
			return new SplitGene()
		}
		
	}
	
}