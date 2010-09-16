package wcl.form
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.Shape;
	
	public class FormManager extends MovieClip
	{
		private static var forms:Array = new Array();	// Holds all the Forms that will be Used in App
		private var currentForm:I_Form;					// Holds the form that is currently displayed
		private var lastForm:I_Form;					// Holds the form that was last displayed
		private var overlay:Shape = new Shape();		
		
		public static var theStage:Stage; 	// Static Global Reference to the stage
											// Useful For dispatching Events to the Form Manager
		public static var me:MovieClip;		// Static Global for Accessing the FormManager
		
		public function FormManager() {
		}
		
		public function initialize() {
			stop();
			theStage = stage;
			me = this;
			
			// These are the event listeners for the Different Form Events
			addEventListener(FormSwitchEvent.SWITCH, formSwap);
		}
		
		// This Function adds a Form to the forms Array
		//   And sets it Index Number
		public function addForm(p_form:I_Form):void
		{
			if (!isInitialized){
				p_form.index = (forms.push(p_form) - 1);		// add the Form to the Array				
			}
		}
		
		private var isInitialized:Boolean = false;
		
		public function initializeAndLock():void
		{
			if (isInitialized) {
				trace("FormManager is Locked");
			}else {
				for (var i:int = 0; i < forms.length; i++){
					(forms[i] as I_Form).initialize();
				}
				isInitialized = true;
			}
		}
		
		// This Function is Attached to the the FormSwitchEvent.SWITCH
		public function formSwap(e:FormSwitchEvent):void{
			if(currentForm != null)
			{
				currentForm.disableAllEvents();									// Disable all Events for the Form that is being Removec
				//currentForm.removeForm();
				lastForm = (removeChild(currentForm as MovieClip) as I_Form); 	// Set the last Form variable and Remove the Form From the Stage
			}
			currentForm = forms[e.next_id]; 									// Set the new form as the Current Form
			addChild(currentForm as MovieClip); 								// Add the New Form to the Stage
			currentForm.enableAllEvents(); 										// Enable all the new Forms Events
		}
	}
}