using Toybox.WatchUi;


class ArrowUpButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.arrowUpButton_default});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>60,
			:locY=>30,
			:width=>100,
			:height=>50
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		System.println("Scroll up");
		globalHistoryView.moveListUp();
	}
}

class ArrowDownButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.arrowDownButton_default});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>60,
			:locY=>180,
			:width=>100,
			:height=>50
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		System.println("Scroll down");
		globalHistoryView.moveListDown();
	}
}

class BackButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.backButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.backButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.backButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.backButton_default});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>25,
			:locY=>25,
			:width=>50,
			:height=>50
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		System.println("Go back");
		returnToWorkTimerPage();
	}
}

class XButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.xButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.xButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.xButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.xButton_default});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>145,
			:locY=>25,
			:width=>50,
			:height=>50
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		System.println("Clear");
	}
}

