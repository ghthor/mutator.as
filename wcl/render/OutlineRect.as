package wcl.render {
	import wcl.render.I_Drawable
	import wcl.math.Rect
	/**
	 * ...
	 * @author ...
	 */
	public class OutlineRect extends wcl.math.Rect implements I_Drawable {
		public var lineColor:uint
		
		public function Rect() {
		}
		
		public override function drawToCanvas(canvas:Canvas):void {
			canvas.graphics.lineStyle(1, lineColor)
			canvas.graphics.moveTo(topLeft.x, -topLeft.y)
			canvas.graphics.drawRect(topLeft.x, -topLeft.y, offset.x, offset.y)
		}
		
	}
	
}