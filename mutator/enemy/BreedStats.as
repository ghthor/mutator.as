package mutator.enemy {
	import wcl.math.RandomFloat;
	import wcl.randomization.Weight;
	import wcl.randomization.WeightedPool;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BreedStats {		
		var aliveTimes:Array = new Array()
		var amountOfDeaths:Number = 0
		public var avgTimeAlive:Number = 0
		var dna:DnaArray
		public var numberOfHits:Number = 0
		
		static var allBreeds:Array = new Array()
		static var newBreedChance:WeightedPool = new WeightedPool()
		
		public static function initialize():void {
			newGeneration()
			
			newBreedChance.addAnItemToPool(new Weight(1, "y"))
			newBreedChance.addAnItemToPool(new Weight(3, "n"))
		}
		
		public static function resetWithFreshGeneration():void {
			// clear allBreeds to make room for the next Gen
			allBreeds.splice(0, allBreeds.length)
			// newGeneration generates all new random breeds if allBreeds.length == 0
			newGeneration()
		}
		
		public static const MAX_BREEDS:uint = 20
		public static function newGeneration():void {
			if ( allBreeds.length != 0 ) {
				// Time to breed the best performers
				var breedsSorted:Array = sortBreeds()
				
				// clear allBreeds to make room for the next Gen
				allBreeds.splice(0, allBreeds.length)
				
				// Pick the top four best performers for breeding
				var bestPerformers:Array
				switch (breedsSorted[0].numberOfHits) {
					case 0:
						bestPerformers = breedsSorted.splice(0, MAX_BREEDS)
						break
					default:
						bestPerformers = breedsSorted.splice(0, 6)
						break
				}				
				var newDna:DnaArray
				var newBreed:EnemyShip
				
				/// A LOT of randomization could go on here aswell
				var breedTimes:uint = 5
				for (var i:int = 1; i < bestPerformers.length; i += 2) {					
					for (var j:int = 0; j < breedTimes; j++) {
						newDna = bestPerformers[i - 1].breed(bestPerformers[i])
						newBreed = EnemyShip.newBreed(newDna)
						allBreeds.push(newBreed)
					}					
				}
				if (newBreedChance.next().type == "y") {
					allBreeds.push(EnemyShip.newBreed())
					if (newBreedChance.next().type == "y") {
						allBreeds.push(EnemyShip.newBreed())
						if (newBreedChance.next().type == "y") {
							allBreeds.push(EnemyShip.newBreed())
						}
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
			breedStats.sortOn(["numberOfHits", "avgTimeAlive"], Array.DESCENDING | Array.NUMERIC)
			trace(breedStats)
			return breedStats
		}
		
		public function breed(stats:BreedStats):DnaArray {
			return dna.breed(stats.dna)
		}
		
		public function toString():String {
			return "[hits: " + numberOfHits + ", avgTimeAlive: " + avgTimeAlive + "]"
		}
	}
	
}