using Toybox.WatchUi;

class WorkTimerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new WorkTimerMenuDelegate(), WatchUi.SLIDE_UP);
        
        return true;
    }

}