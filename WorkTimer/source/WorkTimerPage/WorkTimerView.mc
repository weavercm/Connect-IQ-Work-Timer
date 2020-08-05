using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

//Holds all of the buttons for the Work Timer View
class WorkTimerViewButtons {

	hidden var myClockInButton = null;
	hidden var myClockOutButton = null;
	hidden var myBreakButton = null;
	hidden var myTimeDisplay = null;
	hidden var myHistoryButton = null;

	//Constructor
	public function initialize(dc) {
		myClockInButton = new ClockInButton(dc);
		myClockOutButton = new ClockOutButton(dc);
		myBreakButton = new BreakButton(dc);
		myHistoryButton = new HistoryButton(dc);
	}

	//Returns an array of Work Timer buttons
	public function getButtons() {
		return [myClockInButton, myBreakButton, myClockOutButton, myHistoryButton];
	}

	//Disables the button whose state is currently active
	public function updateState(workState) {
		switch(workState) {
			case TimeLogEntry.ON_CLOCK:
				myClockInButton.setEnable(false);
				myClockOutButton.setEnable(true);
				myBreakButton.setEnable(true);
				break;
			case TimeLogEntry.OFF_CLOCK:
				myClockInButton.setEnable(true);
				myClockOutButton.setEnable(false);
				myBreakButton.setEnable(true);
				break;
			case TimeLogEntry.ON_BREAK:
				myClockInButton.setEnable(true);
				myClockOutButton.setEnable(true);
				myBreakButton.setEnable(false);
				break;
		}
	}
}

//Handles the Work Timer View
class WorkTimerView extends WatchUi.View {
	hidden var globalUpdateTimer = null;
	hidden var timeLogManager = null;
	hidden var buttons = null;

	//Constructor
	function initialize(timeLogManager) {
		self.timeLogManager = timeLogManager;
		View.initialize();
	}

	//Called before displaying graphics. Loads resources here.
	function onLayout(dc) {
		//set up a timer to call onUpdate() every 0.5 sec
		if(globalUpdateTimer == null) {
			globalUpdateTimer = new System.Timer.Timer();
			globalUpdateTimer.start(method(:requestUpdate), 500, true);
		}
		if(buttons == null) {
			buttons = new WorkTimerViewButtons(dc);
		}

		setLayout(buttons.getButtons());

		if(!System.getDeviceSettings().isTouchScreen) {
			setKeyToSelectableInteraction(true);
		}
	}

	//Updates the view
	function onUpdate(dc) {
		buttons.updateState(timeLogManager.getCurState());

		View.onUpdate(dc);

	    dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
	    var currentWorkStateString = TimeLogEntry.timeStateToString(timeLogManager.getCurState());

	    dc.drawText( dc.getWidth() / 2, 25, Graphics.FONT_SMALL,
	    	currentWorkStateString, Graphics.TEXT_JUSTIFY_CENTER |
	    	Graphics.TEXT_JUSTIFY_VCENTER );

	    var currentWorkTimeString = "Work Time:\n" +
	    	getTimeReadable(timeLogManager.getTimeWorked());

	    dc.drawText( dc.getWidth() / 2, dc.getHeight() / 2 - 35,
	    	Graphics.FONT_SMALL, currentWorkTimeString,
	    	Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
	}
}
