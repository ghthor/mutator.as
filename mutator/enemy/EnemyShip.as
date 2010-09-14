package mutator.enemy {
	import wcl.AccurateMovieClip;
	import wcl.math.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EnemyShip extends AccurateMovieClip {
		
		public static var genePool:GenePool = new GenePool()
		
		public static var all:Array = new Array()
		public static var allAlive:Array = new Array()
		public static var allDead:Array = new Array()
		
		var dna:Array = new Array()
		
		public var ticksLived:Number = 0
		
		public var velocity:Vector2D = new Vector2D()
		
		const NUMBER_OF_GENES:uint = 20
		const TICKS_PER_GENE:int = 30
		
		public static function initialize():void {
			// Fill the Gene Pool
		}
		
		public function Enemy() {
			super()
			stop()
		}
		
		public function tick(percent:Number):void {
			// Execute the current Gene
			
			// Move the ship alone the velocity
			x += velocity.x
			y += velocity.y			
		}
	}	
}