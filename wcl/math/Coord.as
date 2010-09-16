package wcl.math
{
	import flash.geom.Point;
	import flash.display.DisplayObject;
	
	public class Coord extends Point
	{
		// Constructor
		public function Coord(i_x:Number = 0, i_y:Number = 0)
		{
			super(i_x, i_y);
		}
		
		public function setWithDisplayObject(p_displayObject:DisplayObject):void{
			x = p_displayObject.x
			y = p_displayObject.y
		}
		
		// Adds a Vector to the Coord and Returns a New Coord after that addition
		public function addVector(i_vect:Vector):Coord
		{
			var r_val:Coord;
			r_val = new Coord(x + i_vect.x, y + i_vect.y);
			return r_val;
		}
		
		// Translates "this" coord by a Vector
		public function moveByVector(p_vect:Vector):void
		{
			x = x + p_vect.x;
			y = y + p_vect.y;
		}
		
		// Creates a Vector from "this" coord to p_coord
		public function combineToVector(p_coord:Coord):Vector
		{
			var r_val:Vector;
			r_val = new Vector(0,0);
			r_val.x = p_coord.x - x;
			r_val.y = p_coord.y - y;
			return r_val;
		}
		
		// Calculates Distance from "this" coord to p_coord
		public function distanceTo(p_coord:Coord):Number
		{
			var r_vect:Vector = combineToVector(p_coord);
			return r_vect.length;
		}
		
		public override function toString():String{
			var r_val:String =  " (" + x + ", " + y + ")";
			return r_val;
		}
	}
}