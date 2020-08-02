using Toybox.Application;
using Toybox.Application.Storage;
using Toybox.WatchUi;

//Starting point for the app
class WorkTimerApp extends Application.AppBase {

	//Constructor
	public function initialize() {
		AppBase.initialize();
	}

	//Called on application start up
	function onStart(state) {
    	//load in history data
    	globalMyTime = new TimeLogManager();
    	try {
    		globalMyTime.load();
    		//globalMyTime.setFromStorageCompatableDict(Storage.getValue(USER_SAVE_ID));
    	}
    	catch(ex) {
    		System.println("Error loading in user save data; Skipping load.");
    	}
    }

	//Called when application is exiting
	function onStop(state) {
    	//store history data
    	globalMyTime.save();
    	//Storage.setValue(USER_SAVE_ID, globalMyTime.getStorageCompatableDict());
    }

	// Return the initial view of application here
	function getInitialView() {
    	globalWorkTimeView = new WorkTimerView();
    	globalWorkTimeDelegate = new WorkTimerDelegate();
    	return [ globalWorkTimeView, globalWorkTimeDelegate];
    }

}
