package wcl {
	
	/**
	 * ...
	 * @author ...
	 */
	public class TempInt extends TemporaryVarible {
		
		private var _val:int
		private var _offset:int;
		
		public function TempInt(initialVal:int, p_parent:I_TemporaryVaribleContainer):void {
			super(p_parent);
			_val = initialVal;
		}
		
		public function get val():int { return _val + _offset; }
		
		public function set val(value:int):void {
			_offset = value - _val;
			isInTemporaryState = true;
		}
		
		override public function commitState():void {
			_val = val;
			_offset = 0;
			super.commitState();
		}
		
		override public function revert():void {
			_offset = 0;
			super.revert();
		}
		
		
	}
	
}