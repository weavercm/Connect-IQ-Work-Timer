using Toybox.WatchUi;
using Toybox.Attention;

class HistoryDelegate extends WatchUi.BehaviorDelegate
{
	function initialize()
	{
		BehaviorDelegate.initialize();
	}
	
	function onSelectable(event)
	{
		var instance = event.getInstance();
		
		if(instance instanceof ArrowUpButton)
		{
			switch(instance.getState())
			{
				case :stateDefault:
//					System.println("Default");
//					System.println("\tThe previous state was " + event.getPreviousState());
//					System.println("\tThe current state is " + instance.getState());
					break;
				case :stateHighlighted:
//					System.println("Highlighted");
//					System.println("\tThe previous state was " + event.getPreviousState());
//					System.println("\tThe current state is " + instance.getState());
					break;
				case :stateSelected:
//					System.println("Selected");
//					System.println("\tThe previous state was " + event.getPreviousState());
//					System.println("\tThe current state is " + instance.getState());
					instance.performAction();
					break;
				case :stateDisabled:
//					System.println("Disabled");
//					System.println("\tThe previous state was " + event.getPreviousState());
//					System.println("\tThe current state is " + instance.getState());
					break;
				default:
//					System.println("null");
				
			}
		}
		else if(instance instanceof ArrowDownButton)
		{
			switch(instance.getState())
			{
				case :stateDefault:
//					System.println("\tDefault");
					break;
				case :stateHighlighted:
//					System.println("\tHighlighted");
					break;
				case :stateSelected:
//					System.println("\tSelected");
					instance.performAction();
					break;
				case :stateDisabled:
//					System.println("\tDisabled");
					break;
				default:
//					System.println("\tnull");
			}
		}
		else if(instance instanceof BackButton)
		{
			switch(instance.getState())
			{
				case :stateDefault:
//					System.println("\tDefault");
					break;
				case :stateHighlighted:
//					System.println("\tHighlighted");
					break;
				case :stateSelected:
//					System.println("\tSelected");
					instance.performAction();
					break;
				case :stateDisabled:
//					System.println("\tDisabled");
					break;
				default:
//					System.println("\tnull");
			}
		}
		else if(instance instanceof XButton)
		{
			switch(instance.getState())
			{
				case :stateDefault:
//					System.println("\tDefault");
					break;
				case :stateHighlighted:
//					System.println("\tHighlighted");
					break;
				case :stateSelected:
//					System.println("\tSelected");
					instance.performAction();
					break;
				case :stateDisabled:
//					System.println("\tDisabled");
					break;
				default:
//					System.println("\tnull");
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
	}
	
	function onMenu()
	{
		returnToWorkTimerPage();
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
		
		XButton.performAction();

		return true;	
	}
}

function returnToWorkTimerPage()
{
	if(globalWorkTimeView == null) {
		globalWorkTimeView = new WorkTimerView();
	}
	if(globalWorkTimeDelegate == null) {
    	globalWorkTimeDelegate = new WorkTimerDelegate();
    }
    WatchUi.pushView(globalWorkTimeView, globalWorkTimeDelegate, WatchUi.SLIDE_IMMEDIATE);
}
