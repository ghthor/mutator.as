package mutator {
	import mutator.BulletRotation;
	import mutator.BulletSize;
	import wcl.AccurateMovieClip;
	import wcl.math.RandomFloat;
	import wcl.math.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Bullet extends AccurateMovieClip {
		
		//public var velocity:Vector2D
		
		private var size:BulletSize
		private var rotater:BulletRotation
		
		public function Bullet(size_:BulletSize = null, rotater_:BulletRotation = null) {
			super()
			if (size_ == null) {
				size = BulletSize.New()
			} else {
				size = size_
			}
			// Update size and rotation
			scaleX = size.scaleX
			scaleY = size.scaleY
			
			if ( rotater_ == null) {
				rotater = BulletRotation.New()
			} else {
				rotater = rotater_
			}
		}
		
		public function initialize():void {
		}
		
		public function clone():Bullet {
			var c:Bullet = new Bullet(size.clone(), rotater.clone())
			return c			
		}
		
		public function randomize():void {
			//randomizeVel()
			size.randomize()
			rotater.randomize()
		}
		
		public function tick(percent:Number):void {
			// Tick the size and rotater
			size.tick(percent)
			rotater.tick(percent)
			
			// Update size and rotation
			scaleX = size.scaleX
			scaleY = size.scaleY
			
			rotation += rotater.nextRotation
		}
		
	}
	
}