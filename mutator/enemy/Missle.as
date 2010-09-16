package mutator.enemy {
	import mutator.form.GameScreen;
	import mutator.Ship;
	import wcl.AccurateMovieClip;
	import wcl.collision.Collidable;
	import wcl.math.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Missle extends AccurateMovieClip implements Collidable {
		
		public static const allMissles:Array = new Array()
		
		// The Breed that fired this missle
		public var breedStats:BreedStats
		
		public static function cleanOutDead():void {
			allMissles = allMissles.filter(_cleanOutMissles)
		}
		
		private static function _cleanOutMissles(missle:Missle, index:int, arr:Array):Boolean {
			return !isDead
		}
		
		public static const typeStr:String = "Missle"
		
		static const MAX_SPEED:Number = 11
		static const MAX_ACCEL:Number = 2
		
		var velocity:Vector2D = new Vector2D()
		var acceleration:Vector2D = new Vector2D()
		
		var targetPoint:Vector2D = new Vector2D()
		
		public function Missle():void {
			super()
		}
		
		public function initialize(targetX:Number, targetY:Number):void {
			targetPoint.setVector2D(targetX, targetY)
		}
		
		public function tick(percent:Number):void {
			if (isOffscreen(GameScreen.SCREEN_EDGE_BUFFER)) {
				destroy()
				return
			}
			
			var toTarget:Vector2D = new Vector2D(x,y)
			toTarget.setToOffsetTo(targetPoint)
			toTarget.makeUnitVector()
			toTarget.scale(MAX_ACCEL)
			
			acceleration.setByVector2D(toTarget)
			
			velocity.addVector2D(acceleration)
			
			velocity.capMagitudeAt(MAX_SPEED)
			
			x += velocity.x
			y += velocity.y
		}
		
		var isDead:Boolean = false
		
		function destroy():void {
			isDead = true
		}
		
		/* INTERFACE wcl.collision.Collidable */
		
		public function get isCollidable():Boolean{
			return !isDead
		}
		
		public function chkCollide(other:Collidable):Boolean{
			if (isCollidable && other.isCollidable) {
				if (hitTestObject(other as DisplayObject)) {
					var overlap:Rectangle = (other as DisplayObject).getBounds(stage).intersection(getBounds(stage))
					var points:Array = new Array(overlap.topLeft, overlap.bottomRight, new Point(overlap.left, overlap.bottom), new Point(overlap.right, overlap.top), new Point(overlap.left + overlap.width / 2, overlap.top + overlap.height / 2))
					for (var j:int = 0; j < points.length; j++) {
						if ((other as DisplayObject).hitTestPoint(points[j].x, points[j].y, true)) {
							return true
						}
					}
				}
			}
			return false
		}
		
		public function collideWith(other:Collidable):void{
			switch(other.type()) {
				case Ship.typeStr:
					destroy()
					// Update Breed Stats
					break
			}
		}
		
		public function type():String{
			return typeStr
		}
		
	}
	
}