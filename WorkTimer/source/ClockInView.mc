using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Attention;

var currentView = null;
var myTime = null;

class ClockInButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockIn_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockIn_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockIn_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.clockIn_disabled});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>10,
			:locY=>120,
			:width=>100,
			:height=>50
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		myTime.setState(ON_CLOCK);
		//setState(:stateDisabled);
		//System.println("\tTest: The current state is " + getState());
	}
}

class ClockOutButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOut_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOut_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOut_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.clockIn_disabled});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>110,
			:locY=>120,
			:width=>100,
			:height=>50
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		myTime.setState(OFF_CLOCK);
	}
}

class BreakButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.break_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.break_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.break_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.break_disabled});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>60,
			:locY=>165,
			:width=>100,
			:height=>50
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		myTime.setState(ON_BREAK);
		myTime.printHistory();
	}
}

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

public enum
	{
		OFF_CLOCK,
		ON_CLOCK,
		ON_BREAK
	}


class MyTimeHistoryUnit
{	
	var state;
	var time;
	
	function initialize(state, time)
	{
		self.state = state;
		self.time = time;
	}
}

class MyTime
{	
	hidden var time;
	hidden var state = OFF_CLOCK;
	hidden var timeHistoryDict = {0=>1};
	hidden var currentDictKey = 0;
	
	
	function initialize(startTime)
	{
		time = startTime;
		timeHistoryDict.put(currentDictKey, new MyTimeHistoryUnit(OFF_CLOCK, System.getClockTime()));
	}
	
	function printHistory()
	{
		var i = 0;
		System.println("History:");
		for(i = 0; i <= currentDictKey; i++)
		{
			System.println("\t" + timeHistoryDict.get(i).time.hour + ":" + timeHistoryDict.get(i).time.min + " " + timeHistoryDict.get(i).state);
		}
	}
	
	function increment()
	{
		switch(state)
		{
			case OFF_CLOCK:
				System.println("Off the clock; will not increment");
				break;
			case ON_CLOCK:
				System.println("On the clock; will increment");
				time++;
				break;
			case ON_BREAK:
				System.println("On break; will not increment");
				break;
			default:
				break;
		}
	}
	
	function setTime(newTime)
	{
		time = newTime;
	}
	
	function getTime()
	{
		return time;
	}
	
	function setState(newState)
	{
		if(newState == state)
		{
			return;
		}
		
		currentDictKey++;
		timeHistoryDict.put(currentDictKey, new MyTimeHistoryUnit(newState, System.getClockTime()));
		
		state = newState;
	}
	
	function getState()
	{
		return state;
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

class MyView extends WatchUi.View
{
	var drawLayer = null;
	var clockLayer = null;
	var myButtons = null;
	var updateTimer = null;
	
	function initialize()
	{

		
		View.initialize();
		
		
	}
	
	function onLayout(dc)
	{
		myTime = new MyTime(0);
	
		updateTimer = new Timer.Timer();
		updateTimer.start(method(:requestUpdate), 500, true);
		
		myButtons = new MyButtons(dc);
		setLayout(myButtons.getButtons());	
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
	
	function onUpdate(dc)
	{
		System.println("Current time is: " + myTime.getTime());
		myTime.increment();
		
		View.onUpdate(dc);
	}
}


class ClockInView extends WatchUi.View
{
	var counter = 0;
	var updateTimer;
	
    function initialize() {
        WatchFace.initialize();
        counter = 1;
        currentView = self;
    }
	
	function onLayout(dc)
	{
		
        
		updateTimer = new Timer.Timer();
		updateTimer.start(method(:requestUpdate), 500, true);
		
		setLayout(Rez.Layouts.myButtonLayout(dc));
	}
	
	function onShow() {
    }
	
	function onUpdate(dc)
	{
		// Get and show the current time
        var clockTime = System.getClockTime();
        
        System.println("updating" + counter);
        
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(100, 100, Graphics.FONT_MEDIUM, counter, Graphics.TEXT_JUSTIFY_LEFT);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        counter++;
		
		
	}
	
	function onPartialUpdate(dc)
	{
		System.println("Updating");
	}
}