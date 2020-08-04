using Toybox.WatchUi;

//Handle input from History View
class HistoryDelegate extends WatchUi.BehaviorDelegate {

	//Constructor
	public function initialize() {
		BehaviorDelegate.initialize();
	}

	//Clear the history list
	public function clearHistory() {
		var message = "Clear History?";
		var isDebug = true;

		if(isDebug) {
			var dialog = new MyConfirmationView(message);
			WatchUi.pushView(dialog, new MyClearHistoryConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
		}
		else {
			var dialog = new WatchUi.Confirmation(message);
			WatchUi.pushView(dialog, new ClearHistoryConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
		}
	}

	//Brings the Work Timer View to the front
	public function goToWorkTimerView() {
		if(globalWorkTimeView == null) {
			globalWorkTimeView = new WorkTimerView();
		}
		if(globalWorkTimeDelegate == null) {
	    	globalWorkTimeDelegate = new WorkTimerDelegate();
	    }
	    WatchUi.pushView(globalWorkTimeView, globalWorkTimeDelegate, WatchUi.SLIDE_IMMEDIATE);
	}

	//Called when menu action is performed
	public function onMenu() {
		goToWorkTimerView();

		return true;
	}

	//Called when next page action is performed
	public function onNextPage() {
		scrollListDown();

		return true;
	}

	//Called when previous page action is performed
	public function onPreviousPage() {
		scrollListUp();

		return true;
	}

	//Called when selection action is performed
	public function onSelect() {
		if(!System.getDeviceSettings().isTouchScreen) {
			clearHistory();
		}

		return true;
	}

	//Called when touch input is received
	public function onSelectable(event) {
		var instance = event.getInstance();

		if(instance instanceof ArrowUpButton) {
			if(instance.getState() == :stateSelected) {
				scrollListUp();
			}
		}
		else if(instance instanceof ArrowDownButton) {
			if(instance.getState() == :stateSelected) {
				scrollListDown();
			}
		}
		else if(instance instanceof TrashButton) {
			if(instance.getState() == :stateSelected) {
				clearHistory();
			}
		}
		else {
			System.println("History View: Did not recognize button");
		}
	}

	//Make lower portions of the history list visible
	public function scrollListDown() {
		globalHistoryView.scrollListDown();
	}

	//Make upper portions of the history list visible
	public function scrollListUp() {
		globalHistoryView.scrollListUp();
	}
}
