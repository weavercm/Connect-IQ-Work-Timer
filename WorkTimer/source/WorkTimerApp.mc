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
    	globalMyTime = new MyTime();
    	globalMyTime.setFromStorageCompatableDict(Storage.getValue("userSave"));
    	globalMyTime.printEntireHistory();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	//store history data
    	Storage.setValue("userSave", globalMyTime.getStorageCompatableDict());
    	globalMyTime.printEntireHistory();
    }

    // Return the initial view of your application here
    function getInitialView() {
    	globalWorkTimeView = new WorkTimerView();
    	globalWorkTimeDelegate = new WorkTimerDelegate();
    	return [ globalWorkTimeView, globalWorkTimeDelegate];
    }

}
