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
			:locY=>10,
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
			:locY=>165,
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