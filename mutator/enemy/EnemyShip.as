package mutator.enemy {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import mutator.form.GameScreen;
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
		
		public function initialize(withDna:DnaArray, andStats:BreedStats = null):void {
			dna = withDna
			
			// This is executed when a newBreed is created
			if (andStats == null) {
				stats = new BreedStats()
				stats.dna = dna
			} else {
				stats = andStats
				
				// if andStats wasn't passed then this is a dns clone and isn't the one associated with stats
				dna.startGene.executeOn(this)
				dna.geneAt(executeGene).enter(this)
			}			
			addChild(draw)
		}
		
		public static function newBreed(withDna:DnaArray = null):EnemyShip {
			var breed:EnemyShip = new EnemyShip()
			if (withDna == null) {
				withDna = genePool.newDna()
			}
			breed.initialize(withDna)
			return breed
		}
		
		public function EnemyShip() {
			super()
			stop()
		}
		
		public function tick(percent:Number):void {
			if (isOffscreen(GameScreen.SCREEN_EDGE_BUFFER/2)) {
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
			// when we split, we want the scale to be that of the cloned
			c.scaleX = scaleX
			c.scaleY = scaleY
			
			// and the location to be the same
			// may have this be conditional based on velocity for an added effect
			c.x = x
			c.y = y
			
			// we also have the life of the cloned
			c.ticksLived = ticksLived
			
			// It is alive and on screen
			parent.addChild(c)
			allAlive.push(c)
		}
		
		override public function get scaleX():Number { return super.scaleX; }
		
		override public function set scaleX(value:Number):void {
			if (value == 0) {
				trace("What is setting this to 0?")
			}
			super.scaleX = value;
		}
		
		public function clone():EnemyShip {
			var c:EnemyShip = new EnemyShip()
			// clone dna and use the same stats object
			c.initialize(dna.clone(),stats)
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