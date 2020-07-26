using Toybox.System;
using Toybox.WatchUi;
using Toybox.Application.Storage;

class ClockInButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockInButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockInButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockInButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.clockInButton_disabled});
		
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
		Storage.setValue("userSave", myTime.getStorageCompatableDict());
	}
}

class ClockOutButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOutButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOutButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOutButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.clockOutButton_disabled});
		
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
		Storage.setValue("userSave", myTime.getStorageCompatableDict());
	}
}

class BreakButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.breakButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.breakButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.breakButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.breakButton_disabled});
		
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
		//myTime.printEntireHistory();
		Storage.setValue("userSave", myTime.getStorageCompatableDict());
	}
}
