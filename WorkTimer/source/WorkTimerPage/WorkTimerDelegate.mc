using Toybox.WatchUi;
using Toybox.Attention;

class WorkTimerDelegate extends WatchUi.BehaviorDelegate
{
	function initialize()
	{
		BehaviorDelegate.initialize();
	}
	
	function onSelectable(event)
	{
		var instance = event.getInstance();
		
		if(instance instanceof ClockInButton)
		{
			//System.println("Clock In:");
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
		else if(instance instanceof ClockOutButton)
		{
			//System.println("Clock Out:");
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
		else if(instance instanceof BreakButton)
		{
			//System.println("Break:");
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
	
	function onMenu()
	{
		globalHistoryView = new HistoryView();
        var delegate = new HistoryDelegate();
        WatchUi.pushView(globalHistoryView, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
	}
}
