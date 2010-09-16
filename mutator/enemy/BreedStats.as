package mutator.enemy {
	import wcl.math.RandomFloat;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BreedStats {
		static var allBreeds:Array = new Array()
		var aliveTimes:Array = new Array()
		var amountOfDeaths:Number = 0
		public var avgTimeAlive:Number = 0
		var dna:DnaArray
		
		public static function initialize():void {
			newGeneration()
		}
		
		public static function resetWithFreshGeneration():void {
			// clear allBreeds to make room for the next Gen
			allBreeds.splice(0, allBreeds.length)
			// newGeneration generates all new random breeds if allBreeds.length == 0
			newGeneration()
		}
		
		public static const MAX_BREEDS:uint = 10
		public static function newGeneration():void {
			if ( allBreeds.length != 0 ) {
				// Time to breed the best performers
				var breedsSorted:Array = sortBreeds()
				
				// clear allBreeds to make room for the next Gen
				allBreeds.splice(0, allBreeds.length)
				
				// Pick the top four best performers for breeding
				var bestPerformers:Array = breedsSorted.splice(0, 4)
				
				var newDna:DnaArray
				var newBreed:EnemyShip
				
				var breedTimes:uint = 4
				for (var i:int = 1; i < bestPerformers.length; i += 2) {					
					for (var j:int = 0; j < breedTimes; j++) {
						newDna = bestPerformers[i - 1].breed(bestPerformers[i])
						newBreed = EnemyShip.newBreed(newDna)
						allBreeds.push(newBreed)
					}					
				}
			} else {
				// the first generation
				for (var i:int = 0; i < MAX_BREEDS; i++) {
					allBreeds.push(EnemyShip.newBreed())
				}
			}
		}
		
		public static function breedFromPool():EnemyShip {
			var index:int = Math.floor(RandomFloat.within(0, allBreeds.length))
			return allBreeds[index].clone()
		}
		
		public function get averageTimeAlive():Number {
			var total:Number = 0
			for (var i:int = 0; i < aliveTimes.length; i++) {
				total += aliveTimes[i]
			}
			avgTimeAlive = total / aliveTimes.length
			if (isNaN(avgTimeAlive)) {
				avgTimeAlive = 0
			}
			return avgTimeAlive
		}
		
		public static function sortBreeds():Array {
			var breedStats:Array = new Array()
			for (var i:int = 0; i < allBreeds.length; i++) {
				breedStats.push(allBreeds[i].stats)
				breedStats[i].averageTimeAlive
			}
			breedStats.sortOn("avgTimeAlive", Array.DESCENDING | Array.NUMERIC)
			trace(breedStats)
			return breedStats
		}
		
		public function breed(stats:BreedStats):DnaArray {
			return dna.breed(stats.dna)
		}
		
		public function toString():String {
			return String(avgTimeAlive)
		}
	}
	
}