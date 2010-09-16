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
		var startGene:Gene
		
		public function breed(otherDna:DnaArray):DnaArray {
			var newDna:DnaArray
			
			switch(Math.floor(RandomFloat.within(0, 4))) {
				case 1:
					newDna = breedInterlace(otherDna)
					break
				case 2:
					newDna = breedRandom(otherDna)
					break
				case 3:
					newDna = breedHalfAndHalf(otherDna)
					break
				default:
					newDna = breedRandom(otherDna)
					break
			}
			return newDna			
		}
		
		// Assumes both Arrays are of the same length
		private function breedInterlace(otherDna:DnaArray):DnaArray {
			var newDna:DnaArray = new DnaArray()
			
			var useOtherDna:Boolean = RandomBool.next()
			
			// Set the startGene
			if (useOtherDna) {
				newDna.startGene = otherDna.startGene.clone()
				useOtherDna = !useOtherDna
			} else {
				newDna.startGene = startGene.clone()
				useOtherDna = !useOtherDna
			}
			
			// Set The Rest
			for (var i:int = 0; i < length; i++) {
				if (useOtherDna) {
					newDna.push(otherDna[i].clone())
					useOtherDna = !useOtherDna
				} else {
					newDna.push(this[i].clone())
					useOtherDna = !useOtherDna
				}
			}
			
			return newDna
		}
		
		public function breedRandom(otherDna:DnaArray):DnaArray {
			var newDna:DnaArray = new DnaArray()
			
			var useOtherDna:Boolean = RandomBool.next()
			
			// Set the Start Gene
			if (useOtherDna) {
				newDna.startGene = otherDna.startGene.clone()
			} else {
				newDna.startGene = startGene.clone()
			}
			
			// Set the Rest
			for (var i:int = 0; i < length; i++) {				
				useOtherDna = RandomBool.next()
				if (useOtherDna) {
					newDna.push(otherDna[i].clone())
				} else {
					newDna.push(this[i].clone())
				}
			}
			
			return newDna
		}
		
		public function breedHalfAndHalf(otherDna:DnaArray):DnaArray {
			var newDna:DnaArray = new DnaArray()
			
			var useOtherDna:Boolean = RandomBool.next()
			
			if (useOtherDna) {
				newDna.startGene = otherDna.startGene.clone()
			} else {
				newDna.startGene = startGene.clone()
			}
			
			var i:int = 0
			for (i = 0; i < length/2; i++) {
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
			// no way to implement this well, gonna have to write my own reverse
			//this = reverse()
		}
		
		public function randomIndex():int {
			var randFloat:Number = RandomFloat.within(0, length)			
			return Math.floor(randFloat)			
		}
		
		public function geneAt(index:int):Gene {
			return this[index] as Gene
		}
		
		public function clone():DnaArray {
			var clone:DnaArray = new DnaArray()
			clone.startGene = startGene.clone()
			for (var i:int = 0; i < length; i++) {
				clone.push(this[i].clone())
			}
			return clone
		}
		
	}	
}