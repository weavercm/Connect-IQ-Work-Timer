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
		        currentWorkTimeString = myTime.getStateAt(listItem) + "-" + myTime.getTimeAt(listItem);
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