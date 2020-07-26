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
    	myTime = new MyTime();
    	//myTime.setFromStorageCompatableDict(Storage.getValue("userSave"));
    	//myTime.printEntireHistory();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	//store history data
    	Storage.setValue("userSave", myTime.getStorageCompatableDict());
    	myTime.printEntireHistory();
    }

    // Return the initial view of your application here
    function getInitialView() {
    	return [ new WorkTimerView(), new WorkTimerDelegate() ];
    }

}
