using Toybox.WatchUi;
using Toybox.Application.Storage;
using Toybox.System;
using Toybox.WatchUi;

//Handle input from Confirmation View
class MyConfirmationDelegate extends WatchUi.BehaviorDelegate {

	hidden var callbackFunc = null;

	//Constructor
	public function initialize(callbackFunc) {
		self.callbackFunc = callbackFunc;
		BehaviorDelegate.initialize();
	}

	//Return to the last view
	public function onBack() {
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		return true;
	}

	//Call callback function when confirm is pressed
	public function onConfirmation() {
		callbackFunc.invoke();
		onBack();
	}

	//Only clear history if input is recieved and is not touch screen
	public function onSelect() {
		if(!System.getDeviceSettings().isTouchScreen) {
			onConfirmation();
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
				onConfirmation();
			}
		}
		else {
			System.println("MyConfirmationDelegate: Did not recognize button");
		}
	}
}


