using Toybox.WatchUi;


class HistoryView extends WatchUi.View
{
	hidden var MY_COLOR_RED = 0xff0015;
	hidden var MY_COLOR_GREEN = 0x00ff15;
	hidden var MY_COLOR_YELLOW = 0xffff00;
	hidden var topOfVisibleList = 0;
	hidden var spaceBetweenEntries = 20;
	public var numItemsDisplayed = 4;
	var arrowUpButton = null;
	var arrowDownButton = null;
	var backButton = null;
	var xButton = null;
	
	function initialize()
	{
		View.initialize();
	}
	
	function onLayout(dc)
	{
		if(arrowUpButton == null) {
			arrowUpButton = new ArrowUpButton(dc);
		}
		
		if(arrowDownButton == null) {
			arrowDownButton = new ArrowDownButton(dc);
		}
		
		if(backButton == null) {
			backButton = new BackButton(dc);
		}
		
		if(xButton == null)	{
			xButton = new XButton(dc);
		}
		
		setLayout([arrowUpButton, arrowDownButton, backButton, xButton]);
		
		numItemsDisplayed = (dc.getHeight() - arrowUpButton.getDistanceFromTop() - arrowDownButton.getDistanceFromBottom()) / spaceBetweenEntries;
	}
	
	function onUpdate(dc)
	{		
		View.onUpdate(dc);
		
		var listItem;
		var screenPos = 0;
		var stateString;
		var currentWorkTimeString;
		
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
        
        if(globalMyTime.currentDictKey <= 0)
        {
        	dc.drawText( dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SMALL, "No History", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
        }
        else
        {
			for(listItem = topOfVisibleList + 1; listItem < topOfVisibleList + numItemsDisplayed + 1; listItem++)
			{
				if(listItem <= globalMyTime.currentDictKey)
				{
					displayHistoryEntryColor(dc, listItem, screenPos);
					screenPos++;
				}
			}
		}
	}
	
	function displayHistoryEntryColor(dc, listItem, screenPos) {
		var stateString = globalMyTime.getStateStringAt(listItem);
		dc.setColor( getColorByState(globalMyTime.getStateAt(listItem)), Graphics.COLOR_TRANSPARENT );
		dc.drawText( dc.getWidth() / 2, 90 + spaceBetweenEntries * screenPos, Graphics.FONT_SMALL, stateString, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER );
		
		var currentWorkTimeString = "-" + globalMyTime.getTimeAt(listItem);
		dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
		dc.drawText( dc.getWidth() / 2 + 5, 90 + spaceBetweenEntries * screenPos, Graphics.FONT_SMALL, currentWorkTimeString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER );
	}
	
	function displayHistoryEntryBW(dc, listItem, screenPos) {
		var currentWorkTimeString = globalMyTime.getStateStringAt(listItem) + "-" + globalMyTime.getTimeAt(listItem);
		dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
	    dc.drawText( dc.getWidth() / 2, 90 + spaceBetweenEntries * screenPos, Graphics.FONT_SMALL, currentWorkTimeString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
	}
	
	function getColorByState(state) {
		switch(state) {
			case OFF_CLOCK:
				return MY_COLOR_RED;
			case ON_CLOCK:
				return MY_COLOR_GREEN;
			case ON_BREAK:
				return MY_COLOR_YELLOW;
			default:
				return Graphics.COLOR_WHITE;
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
		if(topOfVisibleList + 1 <= globalMyTime.currentDictKey - numItemsDisplayed)
		{
			topOfVisibleList++;
		}
	}

}
