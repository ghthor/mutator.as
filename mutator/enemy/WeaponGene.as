package mutator.enemy {
	import mutator.enemy.Gene;
	import mutator.enemy.EnemyShip;
	import mutator.form.GameScreen;
	import wcl.math.RandomFloat;
	import wcl.math.Vector2D;
	import wcl.randomization.Weight;
	
	/**
	 * ...
	 * @author ...
	 */
	public class WeaponGene implements Gene {
		public static const type:String = "WeaponGene"		
		public static var poolWeight:Weight = new Weight(1, type)
		
		var weaponType:String = Missle.typeStr
		var ticksPerFire:int = EnemyShip.TICKS_PER_GENE - 1
		var ticks:int = 0
		var leadDistance:Number = RandomFloat.within(0,20)
		
		/* INTERFACE mutator.enemy.Gene */
		
		public function enter(enemy:EnemyShip):void{
			ticks = 0
		}
		
		public function exit(enemy:EnemyShip):void{
			ticks = 0
		}
		
		public function executeOn(enemy:EnemyShip):void{
			if (ticks >= ticksPerFire) {
				ticks = 0
				var missle:Missle = new Missle()
				var leadVect:Vector2D = GameScreen.ship.velocity.cloneAsVector2D()
				leadVect.makeLength(leadDistance)
				missle.initialize(enemy.x, enemy.y, GameScreen.ship.x + leadVect.x, GameScreen.ship.y + leadVect.y)
				Missle.spawn(missle)
			}
			ticks++
		}
		
		public function clone():Gene{
			var c:WeaponGene = new WeaponGene()
			return c
		}
		
		public function mutate():void {
			// Maybe changed the firerate or something
			// Later can change the weaponType
		}
	}
	
}