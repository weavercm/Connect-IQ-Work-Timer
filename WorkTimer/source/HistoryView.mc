using Toybox.WatchUi;

var globalHistoryView = null;

class HistoryView extends WatchUi.View
{
	hidden var topOfVisibleList = 0;
	public var numItemsDisplayed = 6;
	var arrowUpButton;
	var arrowDownButton;
	
	function initialize()
	{
		View.initialize();
	}
	
	function onLayout(dc)
	{
		arrowUpButton = new ArrowUpButton();
		arrowDownButton = new ArrowDownButton();
		setLayout([arrowUpButton, arrowDownButton]);
	}
	
	function onUpdate(dc)
	{		
		View.onUpdate(dc);
		
		var listItem;
		var screenPos = 0;
		var currentWorkTimeString;
		
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
        
		for(listItem = topOfVisibleList; listItem < topOfVisibleList + numItemsDisplayed; listItem++)
		{
			if(listItem <= myTime.currentDictKey)
			{
		        currentWorkTimeString = myTime.getStateAt(listItem) + " " + myTime.getTimeAt(listItem);
	        	dc.drawText( dc.getWidth() / 2, 60 + 20 * screenPos, Graphics.FONT_SMALL, currentWorkTimeString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
				screenPos++;
			}
		}
	}
	
	function moveListUp()
	{
		if(topOfVisibleList - 1 >= 0)
		{
			topOfVisibleList--;
		}
	}
	
	function moveListDown()
	{
		if(topOfVisibleList + 1 <= myTime.currentDictKey - numItemsDisplayed)
		{
			topOfVisibleList++;
		}
	}

}

class ArrowUpButton extends WatchUi.Selectable
{
	function initialize()
	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUp});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUp_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUp});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.arrowUp});
		
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
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDown});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDown_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDown});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.arrowDown});
		
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