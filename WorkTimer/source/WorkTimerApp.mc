using Toybox.Application;
using Toybox.WatchUi;


//Starting point for the app
class WorkTimerApp extends Application.AppBase {

	hidden const USER_SAVE_ID = "userSave";
	hidden var timeLogManager = null;

	//Constructor
	public function initialize() {
		AppBase.initialize();
	}

	// Return the initial view of application here
	function getInitialView() {
    	return [new WorkTimerView(timeLogManager), new WorkTimerDelegate(timeLogManager)];
    }

	//Called on application start up
	function onStart(state) {
    	//load in history data
    	timeLogManager = new TimeLogManager(USER_SAVE_ID);

    	//Uncomment this code and change as needed 'numEntries' to load in random test data
    	/*
    	var numEntries = 3;
    	timeLogManager.loadInRandomTestData(numEntries);
    	*/

		//Comment out this code for the above testing
    	try {
    		timeLogManager.load();
    	}
    	catch(ex) {
    		System.println("WorkTimerApp: Error loading in user save data; Skipping load.");
    	}
    	//
    }

	//Called when application is exiting
	function onStop(state) {
    	//store history data
    	timeLogManager.save();
    }
}
