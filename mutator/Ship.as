package mutator {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import mutator.form.GameScreen;
	import mutator.form.Mutator;
	import wcl.AccurateMovieClip;
	import wcl.form.FormManager;
	import wcl.math.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Ship extends AccurateMovieClip {
		
		private var bulletSpawnPoint:MovieClip;
		public var currentBulletType:OrbitingBullet
		
		private const MAX_SPEED:Number = 10
		private const ACCELERATION:Number = .5
		
		private const DECELERATION:Number = .25
		
		public var velocity:Vector2D = new Vector2D()
		public var acceleration:Vector2D = new Vector2D()
		
		public function Ship():void {
			stop()
		}
		
		public function initialize():void {
			
			// Starting position
			x = FormManager.theStage.stageWidth/2
			y = FormManager.theStage.stageHeight - 50
			
			bulletSpawnPoint = BulletSpawnPt;
			
			newBulletType()
		}
		
		// This function doesn't take a percent yet
		// TODO:
		public function tick(percent:Number) {
			acceleration.setVector2D(0, 0)
			
			if (north) {
				acceleration.addVector2D(northVect)
			} else {
				
			}
			if (south) {
				acceleration.addVector2D(southVect)
			}
			if (east) {
				acceleration.addVector2D(eastVect)
			}
			if (west) {
				acceleration.addVector2D(westVect)
			}
			vectorNormalizeOverMax(ACCELERATION, acceleration)
			
			velocity.addVector2D(acceleration)
			
			if (acceleration.y == 0 && velocity.y != 0) {
				if (!north && velocity.y < 0) {
					velocity.y += DECELERATION
					if (velocity.y > 0) {
						// Wrapped
						velocity.y = 0
					}
				}
				if (!south && velocity.y > 0) {
					velocity.y -= DECELERATION
					if (velocity.y < 0) {
						// Wrapped
						velocity.y = 0
					}
				}
			}
			if (acceleration.x == 0 && velocity.x != 0) {
				if (!east && velocity.x > 0) {
					velocity.x -= DECELERATION
					// Wrapped
					if (velocity.x < 0) {
						velocity.x = 0
					}
				}
				if (!west && velocity.x < 0) {
					velocity.x += DECELERATION
					// Wrapped
					if (velocity.x > 0) {
						velocity.x = 0
					}
				}
				// Scale it back up just a bit
				if (acceleration.length != 0) {
					//acceleration.makeLength(DECELERATION)
				}
			}
			
			vectorNormalizeOverMax(MAX_SPEED, velocity)
			
			x += velocity.x
			y += velocity.y
			
			/// Keep on  Screen
			// Left
			if (x - (width / 2) < 0 ) {
				x = width / 2
			}
			// Right
			if (x + (width / 2) > Mutator.stageWidth) {
				x = Mutator.stageWidth - width / 2
			}
			// Top
			if (y - (height / 2) < 0 ) {
				y = height / 2
			}
			// Bottom
			if ( y + (height / 2) > Mutator.stageHeight) {
				y = Mutator.stageHeight - height / 2	
			}
		}
		
		var north:Boolean = false
		var south:Boolean = false
		var east:Boolean = false
		var west:Boolean = false
		
		var northVect:Vector2D =	new Vector2D(0, -ACCELERATION)
		var southVect:Vector2D = 	new Vector2D(0,  ACCELERATION)
		var eastVect:Vector2D = 	new Vector2D( ACCELERATION, 0)
		var westVect:Vector2D = 	new Vector2D( -ACCELERATION, 0)
		
		private function vectorNormalizeOverMax(max:Number, vect:Vector2D):void {
			if (vect.length > max) {
				vect.makeLength(max)
			}
		}
		
		public function toggleDirection(direction:String, to:Boolean):void {
			switch(direction) {
				case "n":
					north = to
					break
				case "s":
					south = to
					break
				case "e":
					east = to
					break
				case "w":
					west = to
					break
			}
		}
		
		public function newBulletType():void {
			currentBulletType = new OrbitingBullet()
			currentBulletType.initialize()
			currentBulletType.randomize()
			currentBulletType.defaultVel()
		}
		
		public function fire(gameScreen:GameScreen):void {
			var angle:Number = -105
			var bullet:OrbitingBullet;
			//for (var i:int = 0; i < 5; i++) {
				//bullet = currentBulletType.clone()
				//bullet.initialize()
				//bullet.velocity.setToDegrees(angle)
				//bullet.x = FormManager.theStage.mouseX - bullet.xOffset()
				//bullet.y = FormManager.theStage.mouseY
				//trace(bullet.x + " " + bullet.y)
				//OrbitingBullet.allBullets.push(bullet)
				//gameScreen.addChild(bullet)
				//angle += 5
			//}
			bullet = currentBulletType.clone()
			bullet.initialize()
			bullet.velocity.setToDegrees( -90)
			bullet.x = x - bullet.xOffset() // + bulletSpawnPoint.x
			bullet.y = y  //+ bulletSpawnPoint.y
			OrbitingBullet.allBullets.push(bullet)
			gameScreen.addChild(bullet)
		}
	}
	
}