using Toybox.WatchUi;


//Handle input from History View
class HistoryDelegate extends WatchUi.BehaviorDelegate {

	hidden var historyView = null;
	hidden var timeLogManager = null;

	//Constructor
	public function initialize(timeLogManager, historyView) {
		self.timeLogManager = timeLogManager;
		self.historyView = historyView;
		BehaviorDelegate.initialize();
	}

	//Clears Work Timer history
	public function clearHistory() {
		timeLogManager.clear();
		timeLogManager.save();
	}

	//Brings the Work Timer View to the front
	public function goToWorkTimerView() {
	    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
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
			askClearHistory();
		}

		return true;
	}

	//Called when touch input is received
	public function onSelectable(event) {
		var instance = event.getInstance();

		if(instance instanceof ArrowUpButton) {
			instance.handleEvent(event.getPreviousState(), method(:scrollListUp));
		}
		else if(instance instanceof ArrowDownButton) {
			instance.handleEvent(event.getPreviousState(), method(:scrollListDown));
		}
		else if(instance instanceof TrashButton) {
			instance.handleEvent(event.getPreviousState(), method(:askClearHistory));
		}
		else {
			System.println("HistoryDelegate: Did not recognize button");
		}
	}

	//Make lower portions of the history list visible
	public function scrollListDown() {
		historyView.scrollListDown();
	}

	//Make upper portions of the history list visible
	public function scrollListUp() {
		historyView.scrollListUp();
	}

	//Confirm with the user to clear history
	public function askClearHistory() {
		var message = "Clear History?";
		var myConfirmationView = new MyConfirmationView(message);
		WatchUi.pushView(myConfirmationView, new MyConfirmationDelegate(method(:clearHistory)), WatchUi.SLIDE_IMMEDIATE);
	}
}
