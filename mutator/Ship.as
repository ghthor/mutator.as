package mutator {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import mutator.form.GameScreen;
	import wcl.AccurateMovieClip;
	import wcl.form.FormManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Ship extends AccurateMovieClip {
		
		private var bulletSpawnPoint:MovieClip;
		public var currentBulletType:OrbitingBullet
		
		public function Ship():void {
			stop()
		}
		
		public function initialize():void {
			//FormManager.theStage.addEventListener(MouseEvent.MOUSE_MOVE, mouseListener)
			x = FormManager.theStage.mouseX
			y = FormManager.theStage.mouseY
			
			bulletSpawnPoint = BulletSpawnPt;
			
			currentBulletType = new OrbitingBullet()
			currentBulletType.initialize()
			currentBulletType.randomize()
			currentBulletType.defaultVel()
		}
		
		public function mouseListener(e:MouseEvent):void {
			x = e.stageX;
			y = e.stageY;
		}
		
		public function newBullet():void {
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
			bullet.x = FormManager.theStage.mouseX - bullet.xOffset()
			bullet.y = FormManager.theStage.mouseY
			OrbitingBullet.allBullets.push(bullet)
			gameScreen.addChild(bullet)
			var tacos = 10
			//return currentBulletType.clone()
		}
	}
	
}