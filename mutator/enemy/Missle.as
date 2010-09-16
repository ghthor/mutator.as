package mutator.enemy {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
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
		
		public static var allMissles:Array = new Array()
		
		// The Breed that fired this missle
		public var breedStats:BreedStats			
		var isDead:Boolean = false
		
		public static function cleanOutDead():void {
			allMissles = allMissles.filter(_cleanOutMissles)
		}
		
		private static function _cleanOutMissles(missle:Missle, index:int, arr:Array):Boolean {
			return !missle.isDead
		}
		
		public static const typeStr:String = "Missle"
		
		static const MAX_SPEED:Number = 6
		static const MAX_ACCEL:Number = 1
		
		var velocity:Vector2D = new Vector2D()
		var acceleration:Vector2D = new Vector2D()
		
		var targetPoint:Vector2D = new Vector2D()
		
		public function Missle():void {
			super()
		}
		
		public function initialize(atX:Number, atY:Number, targetX:Number, targetY:Number):void {
			scaleX = .7
			scaleY = .7
			x = atX; y = atY
			targetPoint.setVector2D(targetX, targetY)
			
			var toTarget:Vector2D = new Vector2D(x,y)
			toTarget.setToOffsetTo(targetPoint)
			toTarget.makeUnitVector()
			toTarget.scale(MAX_ACCEL)
			
			acceleration.setByVector2D(toTarget)
		}
		
		public static function spawn(missle:Missle):void {
			GameScreen.addObject(missle)
			allMissles.push(missle)
		}
		
		public function tick(percent:Number):void {
			if (isOffscreen(GameScreen.SCREEN_EDGE_BUFFER)) {
				destroy()
				return
			}			
			velocity.addVector2D(acceleration)
			
			velocity.capMagitudeAt(MAX_SPEED)
			
			rotation = velocity.toDegrees()
			
			x += velocity.x
			y += velocity.y
		}
		
		function destroy():void {
			isDead = true
			if (parent != null) {
				parent.removeChild(this)
			}
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