package mutator.enemy {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import wcl.AccurateMovieClip;
	import wcl.collision.Collidable;
	import wcl.form.FormManager;
	import wcl.math.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EnemyShip extends AccurateMovieClip implements Collidable {
		
		public static var typeStr:String = "EnemyShip"
		
		public static var genePool:GenePool = GenePool.pool
		
		public static var allAlive:Array = new Array()
		public static var allDead:Array = new Array()
		
		var dna:DnaArray
		
		public var ticksLived:Number = 0
		
		public var stats:BreedStats 
		
		public var velocity:Vector2D = new Vector2D()
		public var acceleration:Vector2D = new Vector2D()
		
		public static var constMovement:Vector2D = new Vector2D(0,5)
		
		static const NUMBER_OF_GENES:uint = 20
		static const TICKS_PER_GENE:int = 10
		
		var geneTicks:uint = 0
		var executeGene:uint = 0
		
		var draw:Sprite = new Sprite()
		
		public function get breedAverageTimeAlive():Number {
			return stats.averageTimeAlive
		}
		
		public function initialize(withDna:DnaArray = null):void {
			if (withDna == null) {
				withDna = genePool.newDna()
			}
			dna = withDna
			dna.startGene.executeOn(this)
			dna.geneAt(executeGene).enter(this)
			
			stats = new BreedStats()
			stats.dna = dna
			
			addChild(draw)
		}
		
		public static function newBreed(withDna:DnaArray = null):EnemyShip {
			var breed:EnemyShip = new EnemyShip()
			breed.initialize(withDna)
			return breed
		}
		
		public function EnemyShip() {
			super()
			stop()
		}
		
		public function tick(percent:Number):void {
			if (isOffscreen()) {
				death()
				return
			}
			ticksLived++
			draw.graphics.clear()
			// Execute the current Gene
			getCurrentGene().executeOn(this)
			
			// add the acceleration
			velocity.addVector2D(acceleration)
			
			// Move the ship alone the velocity
			
			if (velocity.length > 20) {
				velocity.makeLength(20)
			}
			x += velocity.x
			y += velocity.y
			
			// add the constant velocity
			x += constMovement.x
			y += constMovement.y			
			
			draw.graphics.lineStyle(2, 0xFF0000)
			draw.graphics.moveTo(0, 0)
			draw.graphics.lineTo(velocity.x*10, velocity.y*10)
		}
		
		public function getCurrentGene():Gene {
			geneTicks++
			if (!(geneTicks < TICKS_PER_GENE)) {
				geneTicks = 0
				// current gene exits
				dna.geneAt(executeGene).exit(this)
				executeGene++
				if (executeGene >= NUMBER_OF_GENES) {
					executeGene = 0
				}
				// next gene enters
				dna.geneAt(executeGene).enter(this)
			}
			return dna.geneAt(executeGene)
		}
		
		public function split():void {
			var c:EnemyShip = clone()
			parent.addChild(c)
			allAlive.push(c)
		}
		
		public function clone():EnemyShip {
			var c:EnemyShip = new EnemyShip()
			c.x = x
			c.y = y
			//c.velocity = velocity.cloneAsVector2D()
			c.dna = dna.clone()
			c.ticksLived = ticksLived
			c.stats = stats
			
			c.addChild(c.draw)
			return c
		}
		
		public static function cleanDead():void {
			allAlive = allAlive.filter(_cleanDead)
		}
		
		private static function _cleanDead(item:EnemyShip, index:int, array:Array):Boolean {
			if (item.isDead) {
				return false
			}
			return true
		}
		
		private function death():void {
			_isDead = true
			allDead.push(this)
			parent.removeChild(this)
			
			stats.amountOfDeaths++
			stats.aliveTimes.push(ticksLived)
		}
		
		var _isDead:Boolean = false
		public function get isDead():Boolean { return _isDead; }
		
		/* INTERFACE wcl.collision.Collidable */		
		
		public function get isCollidable():Boolean {
			return !_isDead
		}
		
		public function chkCollide(other:Collidable):Boolean {
			if (isCollidable && other.isCollidable) {
				return hitTestObject(other as DisplayObject)
			}
			return false
		}
		
		public function collideWith(other:Collidable):void {
			switch(other.type()) {
				case "Bullet":
					death()
					break
			}
		}
		
		public function type():String{
			return typeStr
		}
	}	
}