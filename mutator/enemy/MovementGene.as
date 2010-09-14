package mutator.enemy {
	import mutator.enemy.Gene;
	import wcl.math.RandomFloat;
	import wcl.math.Vector2D;
	import wcl.randomization.Weight;
	
	/**
	 * ...
	 * @author Will Walthall
	 */
	
	// Really really basic, Need to test this to see how it works
	public class MovementGene implements Gene {
		
		var movement:Vector2D
		
		static const MIN_SPEED:Number = 5
		static const MAX_SPEED:Number = 10		
		public static const type:String = "Movement"
		
		public static var poolWeight:Weight = new Weight(1, type)
		
		public function MovementGene() {
			movement = Vector2D.NewWithAngleAndMag(RandomFloat.within(0,360), RandomFloat.within(MIN_SPEED, MAX_SPEED))
		}
		
		/* INTERFACE mutator.enemy.Gene */
		
		public function enter(enemy:EnemyShip):void {			
		}
		
		public function exit(enemy:EnemyShip):void {
			enemy.velocity.setVector2D(0,0)
		}
		
		public function executeOn(enemy:EnemyShip):void {
			//enemy.x += movement.x
			//enemy.y += movement.y
			enemy.velocity.setByVector2D(movement)
		}
		
		public function clone():Gene {
			var c:MovementGene = new MovementGene()
			c.movement = movement.cloneAsVector2D()
			return c
		}
		
	}
}