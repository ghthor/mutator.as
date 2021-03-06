﻿package mutator.form
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import mutator.Bullet;
	import mutator.BulletRotation;
	import mutator.BulletSize;
	import mutator.enemy.BreedStats;
	import mutator.enemy.EnemyShip;
	import mutator.enemy.GenePool;
	import mutator.enemy.Missle;
	import mutator.enemy.ScaleGene;
	import mutator.OrbitingBullet;
	import mutator.Ship;
	import mutator.statistic.Oscillator;
	import wcl.collision.Collidable;
	import wcl.form.*
	import wcl.math.RandomBool;
	import wcl.math.RandomFloat;
	import wcl.math.Vector2D;
	import wcl.randomization.ExamplePool;
	import wcl.randomization.Weight;
	import wcl.render.Canvas;
	/**
	 * ...
	 * @author ...
	 */
	public class GameScreen extends Form implements I_Form
	{
		
		public static const SCREEN_EDGE_BUFFER:Number = 100
		public static const SCROLL_SPEED:Number = 5
		public static var constMovement:Vector2D = new Vector2D(0, SCROLL_SPEED)
		
		public static var gui_scale:TextField
		public static var gui_kills_till_evolution:TextField
		
		private static var me:GameScreen
		public static function addObject(displayObject:DisplayObject):DisplayObject {
			return me.addChild(displayObject)
		}
		
		// useless atm
		var canvas:Canvas = new Canvas()
		
		public static var ship:Ship = new Ship()
		
		public function GameScreen() {
			stop();
		}
		
		public function testingInit() {
			//FormManager.theStage.addEventListener(MouseEvent.MOUSE_MOVE, newRandomBullet)
			FormManager.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUp)
		}
		
		private function spawnEnemy(enemy:EnemyShip):void {
			addChild(enemy)
			EnemyShip.allAlive.push(enemy)
		}
		
		var shipFiring:Boolean = false
		
		/// Run After All Forms Have Been Created
		public function initialize():void {
			me = this
			gui_scale = _gui_scale
			gui_kills_till_evolution = _gui_kills
			GenePool.initialize()
			BreedStats.initialize()
			
			testingInit()
			
			ship.initialize()
			
			addChild(ship);
		}
		
		private function keyDown(e:KeyboardEvent):void {
			var char:String = String.fromCharCode(e.charCode)
			switch(char) {
				default:
					//trace("Key Down: " + e.charCode)
			}
			switch(e.keyCode) {
				case Keyboard.SPACE:
					shipFiring = true
					break
				case Keyboard.UP:
					ship.toggleDirection("n", true)
					break
				case Keyboard.DOWN:
					ship.toggleDirection("s", true)
					break
				case Keyboard.RIGHT:
					ship.toggleDirection("e", true)
					break
				case Keyboard.LEFT:
					ship.toggleDirection("w", true)
					break
			}
		}
		
		private function keyUp(e:KeyboardEvent):void {
			var char:String = String.fromCharCode(e.charCode)
			switch(char) {
				case "a":
					ship.newBulletType()
					break
				case "e":
					spawnEnemy(BreedStats.breedFromPool())
					break
				case "w":
					BreedStats.newGeneration()
					break
				case "n":
					BreedStats.resetWithFreshGeneration()
					break
			}
			switch(e.keyCode) {
				case Keyboard.SPACE:
					shipFiring = false
					break
				case Keyboard.UP:
					ship.toggleDirection("n", false)
					break
				case Keyboard.DOWN:
					ship.toggleDirection("s", false)
					break
				case Keyboard.RIGHT:
					ship.toggleDirection("e", false)
					break
				case Keyboard.LEFT:
					ship.toggleDirection("w", false)
					break
			}
		}
		
		var fireTickCount:int = 0
		var ticksPerFire:int = 8
		
		public static var MIN_TIME_TILL_SPAWN:Number = 10
		public static var MAX_TIME_TILL_SPAWN:Number = 180
		
		public static function decreaseSpawnTime():void {
			MAX_TIME_TILL_SPAWN -= .25
			MIN_TIME_TILL_SPAWN -= .025
			
			if (MIN_TIME_TILL_SPAWN < 4) {
				MIN_TIME_TILL_SPAWN = 4
			}
			if (MAX_TIME_TILL_SPAWN < 10) {
				MAX_TIME_TILL_SPAWN = 10
			}
		}
		
		var timeTillSpawn:Number = RandomFloat.within(MIN_TIME_TILL_SPAWN, MAX_TIME_TILL_SPAWN)
		private function tick(e:Event):void {
			
			if (shipFiring) {
				fireTickCount++
				if (fireTickCount == ticksPerFire) {
					fireTickCount = 0
					ship.fire(this)
				}
			}
			
			if (timeTillSpawn < 0 ) {
				timeTillSpawn = RandomFloat.within(MIN_TIME_TILL_SPAWN, MAX_TIME_TILL_SPAWN)
				spawnEnemy(BreedStats.breedFromPool())
			} else {
				timeTillSpawn -= 1
			}
			
			var enemyShips:Array = EnemyShip.allAlive
			for (var i:int = 0; i < enemyShips.length; i++) {
				enemyShips[i].tick(1.0)
				if (enemyShips[i].scaleX < ScaleGene.MIN) {
					trace("Scale less then min, theres a bug somewhere!")
				}
			}
			var allBullets:Array = OrbitingBullet.allBullets
			for (var i:int = 0; i < allBullets.length; i++) {
				allBullets[i].tick(1.0)
				for (var j:int = 0; j < enemyShips.length; j++) {
					if (enemyShips[j].chkCollide(allBullets[i])) {
						enemyShips[j].collideWith(allBullets[i])
						allBullets[i].collideWith(enemyShips[j])
					}
				}
			}
			
			var allMissles:Array = Missle.allMissles
			for (var i:int = 0; i < allMissles.length; i++) {
				allMissles[i].tick(1.0)
				if (ship.chkCollide(allMissles[i] as Collidable)) {
					ship.collideWith(allMissles[i] as Collidable)
					allMissles[i].collideWith(ship)
				}
			}
			
			ship.tick(1.0)
			
			EnemyShip.cleanDead()
			OrbitingBullet.cleanBullets()
			Missle.cleanOutDead()
		}
		
		public function enableAllEvents():void{
			//btnStart.addEventListener(MouseEvent.CLICK, gotoGameScreen);
			FormManager.theStage.addEventListener(Event.ENTER_FRAME, tick)
			FormManager.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUp)
			FormManager.theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			//FormManager.theStage.addEventListener(MouseEvent.MOUSE_MOVE, updateFacing)
			stage.focus = stage
		}
		
		public function disableAllEvents():void{
			FormManager.theStage.removeEventListener(Event.ENTER_FRAME, tick)
			FormManager.theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUp)
			FormManager.theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			//FormManager.theStage.removeEventListener(MouseEvent.MOUSE_MOVE, updateFacing)
		}
				
		/// Stores the Index in the FormManager's Array of This Form
		static private var _id:int;
		static public function get id():int { return _id; }
				
		public function set index(p_val:int):void{
			_id = p_val;
		}
	}	
}