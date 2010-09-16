package wcl {
	
	/**
	 * ...
	 * @author ...
	 */
	public class TemporaryVarible implements I_TemporaryVariable {
		
		private var _isInTemporaryState:Boolean = false;
		private var parent:I_TemporaryVaribleContainer;
		
		public function TemporaryVarible(p_parent:I_TemporaryVaribleContainer):void {
			parent = p_parent;
			parent.addTempChild(this);
		}
		
		public function commitState():void {
			_isInTemporaryState = false;
		}
		
		public function revert():void {
			_isInTemporaryState = false;
		}
		
		public function get isInTemporaryState():Boolean { return _isInTemporaryState; }		
		public function set isInTemporaryState(value:Boolean):void {
			if (value && !_isInTemporaryState) {
				parent.addTempedChild(this);
				_isInTemporaryState = value;
			}			
		}
	}
	
}