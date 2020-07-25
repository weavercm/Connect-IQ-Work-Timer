using Toybox.System;
using Toybox.WatchUi;

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
		myTime.printEntireHistory();
	}
}
