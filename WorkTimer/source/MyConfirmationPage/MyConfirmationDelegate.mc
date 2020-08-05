using Toybox.WatchUi;
using Toybox.Application.Storage;
using Toybox.System;
using Toybox.WatchUi;

//Handle input from Confirmation View
class MyClearHistoryConfirmationDelegate extends WatchUi.BehaviorDelegate {

	hidden var timeLogManager = null;

	//Constructor
	public function initialize(timeLogManager) {
		self.timeLogManager = timeLogManager;
		BehaviorDelegate.initialize();
	}

	//Clears Work Timer history
	hidden function clearHistory() {
		timeLogManager.clear();
		timeLogManager.save();
	}

	//Return to the last view
	public function onBack() {
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		return true;
	}

	//Only clear history if input is recieved and is not touch screen
	public function onSelect() {
		if(!System.getDeviceSettings().isTouchScreen) {
			clearHistory();
			onBack();
		}

		return true;
	}

	//Called when touch input is received
	public function onSelectable(event) {
		var instance = event.getInstance();

		if(instance instanceof CancelButton) {
			if(instance.getState() == :stateSelected) {
				onBack();
			}
		}
		else if(instance instanceof ConfirmButton) {
			if(instance.getState() == :stateSelected) {
				clearHistory();
				onBack();
			}
		}
		else {
			System.println("Did not recognize button");
		}
	}
}


