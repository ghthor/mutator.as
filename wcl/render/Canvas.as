package wcl.render {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Canvas extends Sprite {
		
		public function defaults():void {
			graphics.moveTo(0, 0);
			graphics.lineStyle(1, 0xffffff);
		}
		
		public function draw(drawable:I_Drawable):void {
			drawable.drawToCanvas(this);
		}
	}
	
}