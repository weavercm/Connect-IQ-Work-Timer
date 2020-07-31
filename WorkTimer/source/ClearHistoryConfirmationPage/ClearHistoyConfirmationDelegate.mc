using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage;

//Handles confirmation dialogue asking if user wants to clear the history
class ClearHistoryConfirmationDelegate extends WatchUi.ConfirmationDelegate {

	//Constructor
	public function initialize() {
		ConfirmationDelegate.initialize();
	}

	//Called in response to user confirming or canceling
	public function onResponse(response) {
        if (response == WatchUi.CONFIRM_YES) {
            clearHistory();
        }
    }

	//Clears Work Timer history
	hidden function clearHistory() {
		globalMyTime.clear();
		Storage.setValue(USER_SAVE_ID, globalMyTime.getStorageCompatableDict());
	}
}
