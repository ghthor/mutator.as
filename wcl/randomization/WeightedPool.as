package wcl.randomization {
	import wcl.math.RandomFloat;
	
	/**
	 * ...
	 * @author Will Walthall
	 */
	public class WeightedPool {
		public var objects:Array = new Array()
		
		public function totalWeight():Number {
			var total:Number = 0
			for (var i:int = 0; i < objects.length; i++) {
				total += (objects[i] as Weight).weight
			}
			return total
		}
		
		public function next():Weight {
			var lowerBounds:Number = 0
			var upperBounds:Number
			
			var thePickValue:Number = RandomFloat.within(0, totalWeight())
			
			var weight:Weight
			for (var i:int = 0; i < objects.length; i++) {
				weight = weightAt(i)
				if (weight.weight == 0) {
					continue
				}
				upperBounds = lowerBounds + weight.weight
				if (thePickValue >= lowerBounds && thePickValue < upperBounds) {
					weight.timesPulled++
					return weight
				}
				lowerBounds = upperBounds
			}
			trace("Some Sort of failure, there wasn't an object to pull")
			return weight
		}
		
		private function weightAt(index:int):Weight {
			return (objects[index] as Weight)
		}
		
		public function addAnItemToPool(weight:Weight):void {
			objects.push(weight)
		}
		
		public function toString():String {
			var str:String = "[Weighted Pool] - Statistics\n"
			var totalPulls:Number = 0
			var totaledWeight = totalWeight()
			var weight:Weight
			var i:int = 0
			for (; i < objects.length; i++) {
				weight = weightAt(i)
				totalPulls += weight.timesPulled
			}
			str += "TotalWeight = "+ totaledWeight + "\n\n"
			str += "type\tWeight\t% Of Pool\t% Pulled\n"
			for (i = 0; i < objects.length; i++) {
				weight = weightAt(i)
				str += weight.type + "\t" + weight.weight + "\t" + 100*weight.weight/totaledWeight + "%\t" + 100*Number(weight.timesPulled)/Number(totalPulls) + "%\n"
			}
			return str
		}
	}
	
}