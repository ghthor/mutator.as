package wcl {
	import wcl.I_TemporaryVariable;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface I_TemporaryVaribleContainer extends I_TemporaryVariable {
		
		function get numTempChildren():uint;
		function get numTempedChildren():uint;
		function addTempChild(tempChild:I_TemporaryVariable):void;
		function addTempedChild(tempChild:I_TemporaryVariable):void;
	}
	
}