package wcl {
	
	/**
	 * ...
	 * @author ...
	 */
	public interface I_TemporaryVariable {
		
		function set isInTemporaryState(value:Boolean):void;
		function get isInTemporaryState():Boolean;
		function commitState():void;
		function revert():void;
		
	}
	
}