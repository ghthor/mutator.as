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
		
		static const MIN_ACCEL:Number = 5/50
		static const MAX_ACCEL:Number = 10/50
		public static const type:String = "Movement"
		
		public static var poolWeight:Weight = new Weight(5, type)
		
		public function MovementGene() {
			movement = Vector2D.NewWithDegreesAndMag(RandomFloat.within(0,360), RandomFloat.within(MIN_ACCEL, MAX_ACCEL))
		}
		
		/* INTERFACE mutator.enemy.Gene */
		
		public function enter(enemy:EnemyShip):void {			
		}
		
		public function exit(enemy:EnemyShip):void {
			//enemy.velocity.setVector2D(0,0)
		}
		
		public function executeOn(enemy:EnemyShip):void {
			//enemy.x += movement.x
			//enemy.y += movement.y
			//enemy.velocity.setByVector2D(movement)
			enemy.acceleration.setByVector2D(movement)
			enemy.draw.graphics.lineStyle(2, 0x00FF00)
			enemy.draw.graphics.moveTo(0, 0)
			enemy.draw.graphics.lineTo(movement.x*10, movement.y*10)
		}
		
		public function clone():Gene {
			var c:MovementGene = new MovementGene()
			c.movement = movement.cloneAsVector2D()
			return c
		}
		
	}
}