using Toybox.Application;
using Toybox.WatchUi;

class WorkTimerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	return [ new MyView(), new MyViewDelegate() ];
        //return [ new ClockInView(), new ClockInDelegate() ];
    }

}
