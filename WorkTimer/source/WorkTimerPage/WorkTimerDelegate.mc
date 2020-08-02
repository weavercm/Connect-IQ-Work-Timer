using Toybox.WatchUi;
using Toybox.Application.Storage;

//Handle input from Work Timer View
class WorkTimerDelegate extends WatchUi.BehaviorDelegate {

	//Constructor
	public function initialize() {
		BehaviorDelegate.initialize();
	}

	//Called when touch input is received
	public function onSelectable(event) {
		var instance = event.getInstance();

		if(instance instanceof ClockInButton) {
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof ClockOutButton)
		{
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof BreakButton)
		{
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof HistoryButton)
		{
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else
		{
			System.println("Did not recognize button");
		}
	}

	//Called when back action is performed
	public function onBack() {
		System.println("Back pressed");
	}

	//Called when menu action is performed
	function onMenu() {
		System.println("Menu pressed");
		goToHistoryView();

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

		return true;
	}

	//Called when selection action is performed
	function onSelect() {
//		switch (globalMyTime.getState(null)) {
//		case OFF_CLOCK:
//		case ON_BREAK:
//			ClockInButton.performAction();
//			break;
//		case ON_CLOCK:
//			ClockOutButton.performAction();
//			break;
//		}

		return true;
	}

	//Brings the History View to the front
	public static function goToHistoryView()
	{
		if(globalHistoryView == null) {
			globalHistoryView = new HistoryView();
		}
		if(globalHistoryDelegate == null) {
	    	globalHistoryDelegate = new HistoryDelegate();
	    }
	    WatchUi.pushView(globalHistoryView, globalHistoryDelegate, WatchUi.SLIDE_IMMEDIATE);
	}
}


