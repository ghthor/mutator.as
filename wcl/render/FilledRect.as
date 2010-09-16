package wcl.render {
	
	/**
	 * ...
	 * @author ...
	 */
	public class FilledRect extends OutlineRect {
		public var fillColor:uint
			
		public override function drawToCanvas(canvas:Canvas):void {
			canvas.graphics.lineStyle(1, lineColor)
			canvas.graphics.beginFill(fillColor)
			canvas.graphics.moveTo(topLeft.x, -topLeft.y)
			canvas.graphics.drawRect(topLeft.x, -topLeft.y, offset.x, offset.y)
		}
	}
	
}