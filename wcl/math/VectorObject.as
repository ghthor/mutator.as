package wcl.math {
	import flash.geom.Point;
	import wcl.render.Canvas;
	import wcl.render.I_Drawable;
	import wcl.math.Offset;
	
	/**
	 * ...
	 * @author ...
	 */
	public class VectorObject implements I_Drawable {
		
		var origin:Point = new Point()
		var offsets:Array = new Array()
		
		public function VectorObject() {
			//origin = p_origin;
			//offsets = p_offsets;
			offsets.push(new Vector2D())
			offsets.pop()
		}
		
		public function setFromJSON(jsonOb:Object) {
			origin.x = jsonOb.Origin.X
			origin.y = jsonOb.Origin.Y
			
			// This needs to be Optimized, extremely wasteful atm
			offsets.slice();
			for (var i:int = 0; i < jsonOb.Offsets.length; i++) {
				offsets[i] = new Vector2D();
				offsets[i].setVector2D((jsonOb.Offsets[i].X as Number), (jsonOb.Offsets[i].Y as Number))
			}
		}
		
		/* INTERFACE wcl.render.I_Drawable */
		
		public function drawToCanvas(canvas:Canvas):void{
			canvas.defaults();
			canvas.graphics.moveTo(origin.x, -origin.y)
			var nextX:Number = 0
			var nextY:Number = 0
			//canvas.graphics.moveTo(nextX, nextY);
			
			for (var i:int = 0; i < offsets.length; i++) {
				nextX = origin.x + offsets[i].x
				nextY = -origin.y + -(offsets[i].y)
				canvas.graphics.lineTo(nextX, nextY);
			}
			canvas.graphics.lineTo(origin.x, -origin.y)
		}
		
	}
	
}