using Toybox.WatchUi;
using Toybox.Application.Storage;

//Handle input from Work Timer View
class WorkTimerDelegate extends WatchUi.BehaviorDelegate {

	//Constructor
	public function initialize() {
		BehaviorDelegate.initialize();
	}

	//Clock in
	public static function clockIn() {
		globalMyTime.addEntry(ON_CLOCK);
		globalMyTime.save();
	}

	//Clock out
	public static function clockOut() {
		globalMyTime.addEntry(OFF_CLOCK);
		globalMyTime.save();
	}

	//Go on break
	public static function goOnBreak() {
		globalMyTime.addEntry(ON_BREAK);
		globalMyTime.save();
	}

	//Brings the History View to the front
	public static function goToHistoryView()
	{
//		if(globalHistoryView == null) {
//			globalHistoryView = new HistoryView();
//		}
		var temp = new HistoryView();

		//if(globalHistoryDelegate == null) {
	    	//globalHistoryDelegate = new HistoryDelegate(temp);
	    //}
	    WatchUi.pushView(temp, new HistoryDelegate(temp), WatchUi.SLIDE_IMMEDIATE);
	}

	//Called when menu action is performed
	function onMenu() {
		//System.println("Menu pressed");
		goToHistoryView();

		return true;
	}

	//Called when touch input is received
	public function onSelectable(event) {
		var instance = event.getInstance();

		if(instance instanceof ClockInButton) {
			if(instance.getState() == :stateSelected) {
				clockIn();
			}
		}
		else if(instance instanceof ClockOutButton) {
			if(instance.getState() == :stateSelected) {
				clockOut();
			}
		}
		else if(instance instanceof BreakButton) {
			if(instance.getState() == :stateSelected) {
				goOnBreak();
			}
		}
		else if(instance instanceof HistoryButton) {
			if(instance.getState() == :stateSelected) {
				goToHistoryView();
			}
		}
		else {
			System.println("Did not recognize button");
		}
	}
}


