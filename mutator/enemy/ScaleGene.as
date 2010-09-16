package mutator.enemy {
	import mutator.enemy.Gene;
	import mutator.enemy.EnemyShip;
	import mutator.statistic.Oscillator;
	import wcl.math.RandomFloat;
	import wcl.randomization.Weight;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScaleGene implements Gene {
		
		public static const type:String = "Scale"
		
		public static var poolWeight:Weight = new Weight(1,type)
		
		public static const MIN:Number = .4
		public static const MAX:Number = 1.5
		
		var scale:Oscillator
		var target:Number
		
		public function ScaleGene():void {
			scale = new Oscillator()
			target = RandomFloat.within(MIN, MAX)
		}
		
		/* INTERFACE mutator.enemy.Gene */
		
		public function enter(enemy:EnemyShip):void {
			scale.setMinMaxWithRandoms(enemy.scaleX, target)
			scale.period = EnemyShip.TICKS_PER_GENE/2
			scale.start = enemy.scaleX
			if (enemy.scaleX == 0) {
				trace("ScaleX == 0 ????")
			}
		}
		
		public function exit(enemy:EnemyShip):void{
		}
		
		public function executeOn(enemy:EnemyShip):void {
			scale.tick(1.0)
			
			enemy.scaleX = scale.cur
			enemy.scaleY = scale.cur
		}
		
		public function clone():Gene{
			var c:ScaleGene = new ScaleGene()
			c.target = target
			return c
		}
		
		public function mutate():void {
			target = RandomFloat.within(MIN, MAX)
		}		
	}
	
}