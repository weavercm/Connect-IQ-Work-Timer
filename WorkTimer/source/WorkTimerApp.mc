using Toybox.Application;
using Toybox.Application.Storage;
using Toybox.WatchUi;

//Starting point for the app
class WorkTimerApp extends Application.AppBase {

	hidden const USER_SAVE_ID = "userSave";
	hidden var timeLogManager = null;

	//Constructor
	public function initialize() {
		AppBase.initialize();
	}

	//Called on application start up
	function onStart(state) {
    	//load in history data
    	timeLogManager = new TimeLogManager(USER_SAVE_ID);
    	try {
    		timeLogManager.load();
    	}
    	catch(ex) {
    		System.println("Error loading in user save data; Skipping load.");
    	}
    }

	//Called when application is exiting
	function onStop(state) {
    	//store history data
    	timeLogManager.save();
    }

	// Return the initial view of application here
	function getInitialView() {
    	return [ new WorkTimerView(timeLogManager), new WorkTimerDelegate(timeLogManager)];
    }

}
