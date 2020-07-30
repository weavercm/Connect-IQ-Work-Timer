using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.Application.Storage;

class WorkTimerDelegate extends WatchUi.BehaviorDelegate
{
	function initialize()
	{
		BehaviorDelegate.initialize();
	}
	
	function onSelectable(event)
	{
		var instance = event.getInstance();
		
		if(instance instanceof ClockInButton) {
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof ClockOutButton)
		{
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof BreakButton)
		{
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else if(instance instanceof HistoryButton)
		{
			if(instance.getState() == :stateSelected) {
				instance.performAction();
			}
		}
		else
		{
			System.println("Did not recognize button");
		}
	}
	
	function onBack()
	{
		System.println("Back pressed");
		
		//return true;
	}

	function onMenu()
	{
		System.println("Menu pressed");
		goToHistoryPage();
		
        return true;
	}
	
	function onNextMode()
	{
		System.println("Next Mode pressed");
		
		return true;
	}
	
	function onNextPage()
	{
		System.println("Next Page pressed");
		
		return true;
	}
	
	function onPreviousMode()
	{
		System.println("Previous Mode pressed");
		
		return true;
	}
	
	function onPreviousPage()
	{
		System.println("Previous Page pressed");
		
		return true;
	}
	
	function onSelect()
	{
		System.println("Select pressed");
		
		switch(globalMyTime.getState())
		{
			case OFF_CLOCK:
			case ON_BREAK:
				ClockInButton.performAction();
				break;
			case ON_CLOCK:
				ClockOutButton.performAction();
				break;
		}
		
		return true;
	}
}

function goToHistoryPage()
{
	if(globalHistoryView == null) {
		globalHistoryView = new HistoryView();
	}
	if(globalHistoryDelegate == null) {
    	globalHistoryDelegate = new HistoryDelegate();
    }
    WatchUi.pushView(globalHistoryView, globalHistoryDelegate, WatchUi.SLIDE_IMMEDIATE);
}
