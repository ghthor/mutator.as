package wcl.math
{
	import flash.geom.Point;
	
	public class Vector2D extends Point
	{
		// Constructor
		public function Vector2D(p_x:Number = 0, p_y:Number = 0) {
			super(p_x, p_y);
			//x = p_x;
			//y = p_y;
		}
		
		public static function NewWithAngleAndMag(angle:Number, magnitude:Number):Vector2D {
			var v:Vector2D = new Vector2D(Math.cos(angle), Math.sin(angle))
			v.scale(magnitude)
			return v
		}
		
		public static function NewWithDegreesAndMag(degrees:Number, magnitude:Number):Vector2D {
			var v:Vector2D = new Vector2D(Math.cos(degrees * Math.PI/180), Math.sin(degrees * Math.PI/180))
			v.scale(magnitude)
			return v
		}
		
		public function cloneAsPoint():Point {
			return clone()
		}
		
		public function cloneAsVector2D():Vector2D {
			return new Vector2D(x,y)
		}
		
		// Sets "this"'s x and y properties
		public function setVector2D(p_x:Number, p_y:Number):void
		{
			x = p_x;
			y = p_y;
		}
		
		public function setWithRadianAndLength(angle:Number, magnitude:Number):void {
			x = Math.cos(angle)
			y = Math.sin(angle)
			
			scale(magnitude)
		}
		
		public function addDegrees(value:Number):void {
			setWithDegreesAndLength(value + toDegrees(), length)
		}
		
		public function setToDegrees(value:Number):void {
			setWithDegreesAndLength(value, length)
		}
		
		public function setWithDegreesAndLength(degrees:Number, magnitude:Number):void {
			setWithRadianAndLength(degrees * Math.PI/180, magnitude)
		}
		
		// Sets "this"'s x and y properties from a Vector2D
		public function setByVector2D(p_vect:Vector2D):void
		{
			x = p_vect.x;
			y = p_vect.y;
		}				
		
		// Adds a Vector2D to "this"
		public function addVector2D(i_vect:Vector2D):void
		{			
			x = x + i_vect.x;
			y = y + i_vect.y;
		}
		
		// Subtracts a Vector2D from "this"
		public function subtractVector2D(p_vect:Vector2D):void
		{
			x = x - p_vect.x;
			y = y - p_vect.y;
		}
		
		public function rotateByDegree(p_degree:Number):void{
			var tempLength:Number = length;
			var tempRotation:Number = toDegrees() + p_degree;
			x = Math.cos(tempRotation * Math.PI/180);
			y = Math.sin(tempRotation * Math.PI/180);
			scale(tempLength);
		}
		
		public function makeLength(p_length:Number):void {
			if (length == 0) { return }
			var scaleRatio:Number = p_length / length
			scale(scaleRatio)
		}
			
		// Scales the Vector2D by an Amount
		public function scale(i_val:Number):void
		{	
			x *= i_val;
			y *= i_val;
		}
		
		// Scales the Vector2D to length 1
		public function makeUnitVector():void
		{	
			var num:Number = 1.0 / length
			//if (isNaN(num)) {
				//trace(this, "Attempted Scale by NaN")
				//scale(10)
				//makeUnitVector()
				//return
			//}
			scale(num);
		}
		
		// Returns a Vector2D that is the UnitVector of "this" Vector2D
		public function toUnitVector():Vector2D
		{
			var r_vect:Vector2D = new Vector2D(x, y);
			r_vect.makeUnitVector();
			return r_vect;
		}
		
		// Returns the Radian Angle Value of this Vector2D
		public function toRadian():Number
		{
			//// Needs Optimization ////
			var t:Number = 0;
			var pi:Number = Math.PI;
			var i_vect:Vector2D = this.toUnitVector();
			if(i_vect.x >= 0 && i_vect.y >= 0)
			{	//1st Quad and 0/90/360
				t = Math.acos(i_vect.x);
			}
			
			else if(i_vect.x < 0 && i_vect.y > 0)
			{	//2nd Quad
				t = Math.acos(i_vect.x);
			}
			
			else if(i_vect.x < 0 && i_vect.y <= 0)
			{	//3rd Quad 180
				t = pi+(pi - Math.acos(i_vect.x));
			}
			
			else if(i_vect.x >= 0 && i_vect.y < 0)
			{	//4th Quad
				t = 2*pi - Math.acos(i_vect.x);
			}
			
			else
			{
				trace(i_vect + " ERROR!!");
			}
			
			return t;
		}
		
		public function OffsetTo(p:Point):Vector2D {
			var v:Vector2D = new Vector2D(p.x - x, p.y - y)
			return v
		}
		
		public function Invert() {
			x = -x
			y = -y
		}
		
		public function Inverted():Vector2D {
			var v:Vector2D = new Vector2D(x, y)
			v.Invert()
			return v
		}
		
		// Returns the Degree Angle Value of this Vector2D
		public function toDegrees():Number
		{
			var t:Number = toRadian();
			return (t * 180/Math.PI);
		}
		
		public override function toString():String{
			var r_val:String =  " <" + x + ", " + y + "> " + "Mag: " + length;
			return r_val;
		}
	}
}