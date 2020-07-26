using Toybox.Application;
using Toybox.Application.Storage;
using Toybox.WatchUi;


class WorkTimerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	//load in history data
    	
    	

    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	//store history data
    	myTime.printEntireHistory();
    	Storage.setValue("userSave", myTime.getStorageCompatableDict());
    }

    // Return the initial view of your application here
    function getInitialView() {
    	return [ new WorkTimerView(), new WorkTimerDelegate() ];
    }

}
