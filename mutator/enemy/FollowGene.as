package mutator.enemy {
	import mutator.enemy.EnemyShip;
	import wcl.math.RandomFloat;
	import wcl.math.Vector2D;
	import wcl.randomization.Weight;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FollowGene extends MovementGene implements Gene {
		public static const type:String = "Follow"
		
		public static var poolWeight:Weight = new Weight(0, type)
		
		static const MIN_FOLLOW_DIST:Number = 100
		static const BUFFER_ZONE:Number = 40
		static const MAX_FOLLOW_DIST:Number = 400
		static const MIN_FOLLOW_ACCEL:Number = MIN_ACCEL - 2
		static const MAX_FOLLOW_ACCEL:Number = MIN_ACCEL
		
		var followSpeed:Number = RandomFloat.within(MIN_FOLLOW_ACCEL, MAX_FOLLOW_ACCEL)		
		
		public function FollowGene():void {
			super()
		}
		
		override public function enter(enemy:EnemyShip):void {
			super.enter(enemy);
		}
		
		override public function executeOn(enemy:EnemyShip):void {
			var leader:EnemyShip
			var allAlive:Array = EnemyShip.allAlive
			
			var enemyLoc:Vector2D = new Vector2D(enemy.x, enemy.y)
			var leaderLoc:Vector2D = new Vector2D()
			var offsetToLeader:Vector2D
			var distance:Number = 0
			var shortestDistance:Vector2D = new Vector2D(MAX_FOLLOW_DIST,0)
			for (var i:int = 0; i < allAlive.length; i++) {
				leader = allAlive[i] as EnemyShip
				leaderLoc.setVector2D(leader.x, leader.y)
				
				offsetToLeader = enemyLoc.OffsetTo(leaderLoc)
				distance = offsetToLeader.length
				if (distance >= (MIN_FOLLOW_DIST + followSpeed) && distance < MAX_FOLLOW_DIST) {
					if (distance <= shortestDistance.length) {
						shortestDistance = offsetToLeader
					}
				}
			}
			// No Ship within follow distance, use the default movement
			if (shortestDistance.length >= MAX_FOLLOW_DIST) {
				super.executeOn(enemy)
			} else { // There is a ship to follow
				shortestDistance.makeLength(followSpeed)
				enemy.velocity.setByVector2D(shortestDistance)
			}
		}
		
		override public function mutate():void {
			super.mutate()
			followSpeed = RandomFloat.within(MIN_FOLLOW_ACCEL, MAX_FOLLOW_ACCEL)
		}
		
	}
	
}