using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage;

class ClearHistoryConfirmationDelegate extends WatchUi.ConfirmationDelegate {

	hidden var historyView;
	
    function initialize() {
    	//self.historyView = historyView;
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_NO) {
            cancelAction();
        } else {
            confirmAction();
        }
    }
    
    function cancelAction() {
    	//do nothing
    }
    
    function confirmAction() {
    	myTime.clear();
		Storage.setValue("userSave", myTime.getStorageCompatableDict());
    }
}
