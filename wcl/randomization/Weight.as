package wcl.randomization {
	
	/**
	 * ...
	 * @author ...
	 */
	public class Weight {
		public var weight:Number
		public var type:String
		public var id:uint
		public var timesPulled:uint = 0
		
		public function Weight(weight_:Number, type_:String = "", id_:uint = 0) {
			weight = weight_
			type = type_
			id = id_
		}
		
		public function toString():String {
			return "[Weight] id: " + id + " type: " + type + " weight: " + weight
		}
	}
	
}