package mutator.enemy {
	import mutator.enemy.Gene;
	import wcl.math.RandomBool;
	import wcl.math.RandomFloat;
	
	/**
	 * ...
	 * @author ...
	 */
	public dynamic class DnaArray extends Array
	{
		
		public function breed(otherDna:DnaArray) {
			
		}
		
		// Assumes both Arrays are of the same length
		private function breedInterlace(otherDna:DnaArray):DnaArray {
			var newDna:DnaArray = new DnaArray()
			
			var useOtherDna:Boolean = RandomBool.next()
			
			for (var i:int = 0; i < length; i++) {
				if (useOtherDna) {
					newDna.push(otherDna[i].clone())
					useOtherDna = !useOtherDna
				} else {
					newDna.push(this[i].clone())
				}
			}
			
			return newDna
		}
		
		public function breedRandom(otherDna:DnaArray):DnaArray {
			var newDna:DnaArray = new DnaArray()
			
			var useOtherDna:Boolean = RandomBool.next()
			
			for (var i:int = 0; i < length; i++) {
				if (useOtherDna) {
					newDna.push(otherDna[i].clone())
				} else {
					newDna.push(this[i].clone())
				}
				useOtherDna = RandomBool.next()
			}
			
			return newDna
		}
		
		public function breedHalfAndHalf(otherDna:DnaArray):DnaArray {
			var newDna:DnaArray = new DnaArray()
			
			var useOtherDna:Boolean = RandomBool.next()
			
			var i:int = 0
			for (var i:int = 0; i < length/2; i++) {
				if (useOtherDna) {
					newDna.push(otherDna[i].clone())
				} else {
					newDna.push(this[i].clone())
				}
			}
			useOtherDna = !useOtherDna
			
			for (; i < length; i++) {
				if (useOtherDna) {
					newDna.push(otherDna[i].clone())
				} else {
					newDna.push(this[i].clone())
				}
			}
			
			return newDna
		}
		
		public function mutate():void {
			
		}
		
		public function mutateSwap():void {
			_mutateSwap(randomIndex(), randomIndex())
		}
		
		private function _mutateSwap(i:int, j:int):void {
			if (i == j) {
				_mutateSwap(randomIndex(), randomIndex())
				return
			}
			var temp:Object = this[i]
			this[i] = this[j]
			this[j] = temp
		}
		
		public function mutateIntoNewGene():void {
			var i:int = randomIndex()
			
			// i == newGene() // This needs access to a GenePool
		}
		
		public function mutateReverse():void {
			this = reverse()
		}
		
		public function randomIndex():int {
			var randFloat:Number = RandomFloat.within(0, length)			
			return Math.floor(randFloat)			
		}
		
	}	
}