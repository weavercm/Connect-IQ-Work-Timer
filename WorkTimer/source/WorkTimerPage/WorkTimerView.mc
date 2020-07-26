using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Math;
using Toybox.Lang;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Attention;

var currentView = null;
var myTime = null;


class MyTimeDisplay extends WatchUi.View
{
	var timeToDisplay;

	function initialize()
	{
		View.initialize();
	}
	
	function onLayout(dc)
	{
		timeToDisplay = System.getClockTime();
		var timeString = Lang.format("$1$:$2$", [timeToDisplay.hour, timeToDisplay.min.format("%02d")]);
		
		View.setLayout(dc);
	}
	
	function onUpdate(dc)
	{
		View.onUpdate(dc);
	}
}


class MyButtons
{
	var myClockInButton = null;
	var myClockOutButton = null;
	var myBreakButton = null;
	var myTimeDisplay = null;
	
	function initialize(dc)
	{
		myClockInButton = new ClockInButton();
		myClockOutButton = new ClockOutButton();
		myBreakButton = new BreakButton();
		myTimeDisplay = new MyTimeDisplay();
	}
	
	function getButtons()
	{
		return [myClockInButton, myClockOutButton, myBreakButton];
	}
}

var updateTimer = null;

class WorkTimerView extends WatchUi.View
{
	var drawLayer = null;
	var clockLayer = null;
	var myButtons = null;
	//var updateTimer = null;
	
	function initialize()
	{
		View.initialize();
	}
	
	// Load your resources here
	function onLayout(dc)
	{
		if(myTime == null)
		{
			myTime = new MyTime(0);
		}
		
		if(updateTimer == null)
		{	
			updateTimer = new System.Timer.Timer();
			updateTimer.start(method(:requestUpdate), 500, true);
		}
		
		myButtons = new MyButtons(dc);
		setLayout(myButtons.getButtons());
		//setLayout(Rez.Layouts.WorkTimeTextLayout(dc));	
		//setLayout(dc);
		
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
        //dc.clear();
		
		//var myBitResource = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockIn_default});
		clockLayer = new WatchUi.Layer({:locX=>50, :locY=>50, :width=>110, :height=>110});
		var clockLayerDc = clockLayer.getDc();
		clockLayerDc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		clockLayerDc.drawText(50, 50, Graphics.FONT_MEDIUM, "time", Graphics.TEXT_JUSTIFY_CENTER);
	
		addLayer(clockLayer);
	}
	
	// Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
	
	// Update the view
	function onUpdate(dc)
	{
		System.println("WorkTime: " + getTimeReadable(myTime.getTimeWorked()));
		
		View.onUpdate(dc);

        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
        var currentWorkTimestring = myTime.stateToString(myTime.getState()) + "\n\n" + "Work Time:\n" + getTimeReadable(myTime.getTimeWorked());
        dc.drawText( dc.getWidth() / 2, dc.getHeight() / 2 - 45, Graphics.FONT_SMALL, currentWorkTimestring, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
	}
	
	// Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}


//class ClockInView extends WatchUi.View
//{
//	var counter = 0;
//	var updateTimer;
//	
//    function initialize() {
//        WatchFace.initialize();
//        counter = 1;
//        currentView = self;
//        View.initialize();
//    }
//	
//	function onLayout(dc)
//	{
//		
//        
//		updateTimer = new System.Timer.Timer();
//		updateTimer.start(method(:requestUpdate), 500, true);
//		
//		setLayout(Rez.Layouts.myButtonLayout(dc));
//	}
//	
//	function onShow() {
//    }
//	
//	function onUpdate(dc)
//	{
//		// Get and show the current time
//        var clockTime = System.getClockTime();
//        
//        System.println("updating" + counter);
//        
//        dc.clear();
//        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
//        dc.drawText(100, 100, Graphics.FONT_MEDIUM, counter, Graphics.TEXT_JUSTIFY_LEFT);
//
//        // Call the parent onUpdate function to redraw the layout
//        View.onUpdate(dc);
//        counter++;
//		
//		
//	}
//	
//	function onPartialUpdate(dc)
//	{
//		System.println("Updating");
//	}
//}



