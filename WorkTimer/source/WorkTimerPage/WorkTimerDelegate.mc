using Toybox.WatchUi;


//Handle input from Work Timer View
class WorkTimerDelegate extends WatchUi.BehaviorDelegate {

	hidden var timeLogManager = null;

	//Constructor
	public function initialize(timeLogManager) {
		self.timeLogManager = timeLogManager;
		BehaviorDelegate.initialize();
	}

	//Clock in
	public function clockIn() {
		timeLogManager.addEntry(TimeLogEntry.ON_CLOCK);
		timeLogManager.save();
	}

	//Clock out
	public function clockOut() {
		timeLogManager.addEntry(TimeLogEntry.OFF_CLOCK);
		timeLogManager.save();
	}

	//Go on break
	public function goOnBreak() {
		timeLogManager.addEntry(TimeLogEntry.ON_BREAK);
		timeLogManager.save();
	}

	//Brings the History View to the front
	public function goToHistoryView()
	{
		var historyView = new HistoryView(timeLogManager);

	    WatchUi.pushView(historyView, new HistoryDelegate(timeLogManager, historyView), WatchUi.SLIDE_IMMEDIATE);
	}

	//Go to History View when menu action is performed
	public function onMenu() {
		goToHistoryView();

		return true;
	}

	//Called when touch input is received
	public function onSelectable(event) {
		var instance = event.getInstance();

		if(instance instanceof ClockInButton) {
			instance.handleEvent(event.getPreviousState(), method(:clockIn));
		}
		else if(instance instanceof ClockOutButton) {
			instance.handleEvent(event.getPreviousState(), method(:clockOut));
		}
		else if(instance instanceof BreakButton) {
			instance.handleEvent(event.getPreviousState(), method(:goOnBreak));
		}
		else if(instance instanceof HistoryButton) {
			//Without this if-statement upon returning to the Work Timer View,
			//the History button cannot be immeadiately selected
			if(instance.handleEvent(event.getPreviousState(), method(:goToHistoryView))) {
				instance.setState(:stateHighlighted);
			}
		}
		else {
			System.println("WorkTimerDelegate: Did not recognize button");
		}
	}
}


