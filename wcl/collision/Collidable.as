package wcl.collision {
	import flash.display.DisplayObject;
	public interface Collidable {
		function get isCollidable():Boolean
		function chkCollide(other:Collidable):Boolean
		function collideWith(other:Collidable):void
		function type():String
	}
	
}