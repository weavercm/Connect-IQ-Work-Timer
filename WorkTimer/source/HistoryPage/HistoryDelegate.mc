using Toybox.WatchUi;

//Handle input from History View
class HistoryDelegate extends WatchUi.BehaviorDelegate {

	//Constructor
	public function initialize() {
		BehaviorDelegate.initialize();
	}

	//Called when touch input is received
	public function onSelectable(event) {
		var instance = event.getInstance();

		if(instance instanceof ArrowUpButton) {
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof ArrowDownButton) {
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof BackButton)	{
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof XButton) {
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else
		{
			System.println("History View: Did not recognize button");
		}
	}

	//Called when back action is performed
	public function onBack() {
		System.println("Back pressed");
	}

	//Called when menu action is performed
	public function onMenu() {
		returnToWorkTimerView();

		return true;
	}

	//Called when next mode action is performed
	public function onNextMode() {
		System.println("Next Mode pressed");

		return true;
	}

	//Called when next page action is performed
	public function onNextPage() {
		System.println("Next Page pressed");
		ArrowDownButton.performAction();

		return true;
	}

	//Called when previous mode action is performed
	public function onPreviousMode() {
		System.println("Previous Mode pressed");

		return true;
	}

	//Called when previous page action is performed
	public function onPreviousPage() {
		System.println("Previous Page pressed");
		ArrowUpButton.performAction();

		return true;
	}

	//Called when selection action is performed
	public function onSelect() {
		System.println("Select pressed");

		// XButton.performAction();

		return true;
	}

	//Brings the Work Timer View to the front
	public function returnToWorkTimerView() {
		if(globalWorkTimeView == null) {
			globalWorkTimeView = new WorkTimerView();
		}
		if(globalWorkTimeDelegate == null) {
	    	globalWorkTimeDelegate = new WorkTimerDelegate();
	    }
	    WatchUi.pushView(globalWorkTimeView, globalWorkTimeDelegate, WatchUi.SLIDE_IMMEDIATE);
	}
}
