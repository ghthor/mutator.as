package mutator.enemy {
	import mutator.enemy.EnemyShip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FollowGene extends MovementGene implements Gene {
		public static const type:String = "Follow"
		
		static const MIN_FOLLOW_DIST:Number = 50
		static const MAX_FOLLOW_DIST:Number = 400
		static const MAX_FOLLOW_SPEED:Number = MAX_SPEED + 2
		
		public function FollowGene():void {
			super()
		}
		
		override public function enter(enemy:EnemyShip):void {
			super.enter(enemy);
		}
		
	}
	
}