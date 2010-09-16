package mutator.enemy {	
	import mutator.enemy.Gene;
	import mutator.enemy.EnemyShip;
	import mutator.form.Mutator;
	import wcl.math.RandomFloat;
	
	/// Every Enemy has to have 1 of these, so it has special meaning
	/// and it isn't in the GenePool
	public class StartAreaGene implements Gene {
		
		static const numberOfStartZones:uint = 10
		static const startZoneLength:Number = 800 / 10
		
		// This param is kept through a clone
		var startZone:uint
		
		// This param is always randomized so they don't always spawn in exactly the same place
		var startOffset:Number = RandomFloat.within(0, 800/ 10)
		
		public function StartAreaGene(startZone_:uint = numberOfStartZones) {
			if (startZone_ == numberOfStartZones) {
				startZone = Math.floor(RandomFloat.within(0, numberOfStartZones))
			} else {
				startZone = startZone_
			}
		}
		
		/* INTERFACE mutator.enemy.Gene */
		
		public function enter(enemy:EnemyShip):void{			
		}
		
		public function exit(enemy:EnemyShip):void{			
		}
		
		public function executeOn(enemy:EnemyShip):void{
			enemy.x = startZone*startZoneLength + startOffset
		}
		
		public function clone():Gene{
			var c:StartAreaGene = new StartAreaGene(startZone)
			return c
		}		
	}
	
}