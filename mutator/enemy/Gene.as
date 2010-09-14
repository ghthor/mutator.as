package mutator.enemy {
	
	public interface Gene {
		
		function enter(enemy:EnemyShip):void
		function exit(enemy:EnemyShip):void
		function executeOn(enemy:EnemyShip)
		function clone():Gene
	}
}