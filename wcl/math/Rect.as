package wcl.math {
	import flash.geom.Point;
	import wcl.render.Canvas;
	import wcl.render.I_Drawable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Rect implements I_Drawable {
		public var botLeft:Point = new Point()
		public var offset:Vector2D = new Vector2D()
				
		public function get topRight():Point {
			var temp = new Point(botLeft.x + offset.x, botLeft.y + offset.y)
			return temp
		}
		
		public function get topLeft():Point {
			var temp = new Point(botLeft.x, botLeft.y + offset.y)
			return temp
		}
		
		public function get botRight():Point {
			var temp = new Point(botLeft.x + offset.x, botLeft.y)
			return temp
		}
		
		public function setFromJSON(jsonOb:Object) {
			botLeft.x = jsonOb.O.X
			botLeft.y = jsonOb.O.Y
			offset.x = jsonOb.V.X
			offset.y = jsonOb.V.Y
		}
		/* INTERFACE wcl.render.I_Drawable */
		
		public function drawToCanvas(canvas:Canvas):void{
			canvas.defaults()
			canvas.graphics.moveTo(topLeft.x, -topLeft.y)
			canvas.graphics.drawRect(topLeft.x, -topLeft.y, offset.x, offset.y)
		}
		
		/* INTERFACE wcl.render.I_Drawable */
		
	}
	
}