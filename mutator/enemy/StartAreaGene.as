package mutator.enemy {	
	import mutator.enemy.Gene;
	import mutator.enemy.EnemyShip;
	import mutator.form.Mutator;
	import wcl.math.RandomBool;
	import wcl.math.RandomFloat;
	
	/// Every Enemy has to have 1 of these, so it has special meaning
	/// and it isn't in the GenePool
	public class StartAreaGene implements Gene {
		
		static const numberOfStartZones:uint = 10
		static var startZoneLength:Number	// Has to be initialized in frame 1
		
		// This param is kept through a clone
		var startZone:uint
		
		// This param is always randomized so they don't always spawn in exactly the same place
		var startOffset:Number
		
		public static function initialize():void {
			startZoneLength = Mutator.stageWidth / numberOfStartZones
		}
		
		public function StartAreaGene(startZone_:uint = numberOfStartZones) {
			if (startZone_ == numberOfStartZones) {
				startZone = Math.floor(RandomFloat.within(0, numberOfStartZones))
			} else {
				startZone = startZone_
			}
			startOffset = RandomFloat.within(0, startZoneLength)
		}
		
		/* INTERFACE mutator.enemy.Gene */
		
		public function enter(enemy:EnemyShip):void{
		}
		
		public function exit(enemy:EnemyShip):void{
		}
		
		public function executeOn(enemy:EnemyShip):void{
			enemy.x = startZone * startZoneLength + startOffset
			enemy.y = 0
		}
		
		public function clone():Gene{
			var c:StartAreaGene = new StartAreaGene(startZone)
			return c
		}
		
		// Now shifts the startZone based on location
		// Max delta is 2 if the startZone is on one of the edges
		public function mutate():void {
			if (startZone == (numberOfStartZones - 1)) {
				if (RandomBool.next()) {
					startZone -= 1
				} else {
					startZone -= 2
				}
			} else if ( startZone == 0) {
				if (RandomBool.next()) {
					startZone += 1
				} else {
					startZone += 2
				}
			} else {
				if (RandomBool.next()) {
					startZone -= 1
				} else {
					startZone += 1
				}
			}
			startOffset = RandomFloat.within(0, startZoneLength)
		}
	}
	
}