using Toybox.WatchUi;


class ArrowUpButton extends WatchUi.Selectable
{
	hidden var distanceFromTop;
	
	function initialize(dc)
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
			:locX=>(dc.getWidth() - buttonDefault.width) / 2,
			:locY=>40,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};
		
		Selectable.initialize(settings);
		
		distanceFromTop = locY + height;
	}
	
	function getDistanceFromTop()
	{
		return distanceFromTop;
	}
	
	function performAction()
	{
		//System.println("Scroll up");
		globalHistoryView.moveListUp();
	}
}

class ArrowDownButton extends WatchUi.Selectable
{
	hidden var distanceFromBottom;
	
	function initialize(dc)
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
			:locX=>(dc.getWidth() - buttonDefault.width) / 2,
			:locY=>dc.getHeight() - buttonDefault.height - 20,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};
		
		Selectable.initialize(settings);

		distanceFromBottom = dc.getHeight() - locY;			
	}
	
	function getDistanceFromBottom()
	{
		return distanceFromBottom;
	}
	
	function performAction()
	{
		//System.println("Scroll down");
		globalHistoryView.moveListDown();
	}
}

class BackButton extends WatchUi.Selectable
{
	function initialize(dc)
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
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		//System.println("Go back");
		returnToWorkTimerPage();
	}
}

class XButton extends WatchUi.Selectable
{
	
	function initialize(dc)
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.xButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.xButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.xButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.xButton_highlighted});
		
		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>dc.getWidth() - 25 - buttonDefault.width,
			:locY=>25,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};
		
		Selectable.initialize(settings);			
	}
	
	function performAction()
	{
		//System.println("Clear");

		var message = "Clear History?";
		var dialog = new WatchUi.Confirmation(message);
		WatchUi.pushView(dialog, new ClearHistoryConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);	
	}
}

