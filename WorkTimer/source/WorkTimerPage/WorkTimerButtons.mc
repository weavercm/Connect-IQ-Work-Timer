using Toybox.System;
using Toybox.WatchUi;
using Toybox.Application.Storage;

class ClockInButton extends WatchUi.Selectable
{
	function initialize(dc)
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
			:locY=>dc.getHeight() - 2 * buttonDefault.height - 5,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};
		
		Selectable.initialize(settings);			
	}
	
	static function performAction()
	{
		globalMyTime.setState(ON_CLOCK);
		Storage.setValue("userSave", globalMyTime.getStorageCompatableDict());
	}
}

class ClockOutButton extends WatchUi.Selectable
{
	function initialize(dc)
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
			:locX=>dc.getWidth() - buttonDefault.width - 10,
			:locY=>dc.getHeight() - 2 * buttonDefault.height - 5,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		globalMyTime.setState(OFF_CLOCK);
		Storage.setValue("userSave", globalMyTime.getStorageCompatableDict());
	}
}

class BreakButton extends WatchUi.Selectable
{
	function initialize(dc)
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
			:locX=>(dc.getWidth() - buttonDefault.width) / 2,
			:locY=>dc.getHeight() - buttonDefault.height - 5,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		globalMyTime.setState(ON_BREAK);
		//myTime.printEntireHistory();
		Storage.setValue("userSave", globalMyTime.getStorageCompatableDict());
	}
}

class HistoryButton extends WatchUi.Selectable
{
	function initialize(dc)
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.historyButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.historyButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.historyButton_default});
		var buttonDisabled = new WatchUi.Bitmap({:rezId=>Rez.Drawables.historyButton_default});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>(dc.getWidth() - buttonDefault.width) / 2,
			:locY=>(dc.getHeight() / 2) - buttonDefault.height + 5,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		//System.println("Go to History");
		goToHistoryPage();
	}
}
