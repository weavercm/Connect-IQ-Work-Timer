using Toybox.WatchUi;


//Handles the History View
class HistoryView extends WatchUi.View {
	hidden const MY_COLOR_RED = 0xff0015;
	hidden const MY_COLOR_GREEN = 0x00ff15;
	hidden const MY_COLOR_YELLOW = 0xffff00;
	hidden const SPACE_BETWEEN_ENTRIES = 20;
	hidden var topOfVisibleList = 0;
	hidden var reachedBottomOfList = false;
	hidden var reachedTopOfList = false;
	hidden var numItemsDisplayed;
	hidden var arrowUpButton = null;
	hidden var arrowDownButton = null;
	hidden var trashButton = null;
	hidden var timeLogManager = null;

	//Constructor
	public function initialize(timeLogManager) {
		self.timeLogManager = timeLogManager;
		View.initialize();
	}

	//Called before displaying graphics. Loads resources here.
	public function onLayout(dc) {
		if(arrowUpButton == null) {
			arrowUpButton = new ArrowUpButton(dc);
		}
		if(arrowDownButton == null) {
			arrowDownButton = new ArrowDownButton(dc);
		}
		if(trashButton == null)	{
			trashButton = new TrashButton(dc);
		}

		setLayout([arrowUpButton, arrowDownButton, trashButton]);

		numItemsDisplayed = (dc.getHeight() - arrowUpButton.getDistanceFromTop() -
			arrowDownButton.getDistanceFromBottom() - 5) / SPACE_BETWEEN_ENTRIES;
	}

	//Updates the view
	public function onUpdate(dc) {
		View.onUpdate(dc);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        //globalMyTime.loadInTestData();

        if(timeLogManager.getSize() <= 0) {
        	dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2,
        		Graphics.FONT_SMALL, "No History",
        		Graphics.TEXT_JUSTIFY_CENTER |
        		Graphics.TEXT_JUSTIFY_VCENTER);
        	trashButton.setState(:stateDisabled);
        	arrowUpButton.setState(:stateDisabled);
        	arrowDownButton.setState(:stateDisabled);
        }
        else {
			displayList(dc);
			trashButton.setState(:stateDefault);
		}
	}

	//Displays the current visible portion of the history list
	hidden function displayList(dc) {
		var listItem = topOfVisibleList + 1;
		var screenPos = 0;
		var curWorkTimeString = "";
		var curDateString = "";
		var nextDateString = "";

		for(screenPos = 0; screenPos < numItemsDisplayed; screenPos++) {
			if(listItem <= timeLogManager.getSize()) {
				nextDateString = timeLogManager.getDateStringAt(listItem);

				if(!curDateString.equals(nextDateString)) {
					curDateString = nextDateString;
					dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
					dc.drawText( dc.getWidth() / 2,
						80 + SPACE_BETWEEN_ENTRIES * screenPos, Graphics.FONT_SMALL,
						curDateString, Graphics.TEXT_JUSTIFY_CENTER |
						Graphics.TEXT_JUSTIFY_VCENTER );
				}
				else {
					displayHistoryEntryColor(dc, listItem, screenPos);
					listItem++;
				}
			}
		}
		updateListReachedBottomTopFlags(listItem);
	}

	//Sets the flags that indicate if the history list is at the top or bottom
	hidden function updateListReachedBottomTopFlags(listItem) {
		if(listItem > timeLogManager.getSize()) {
				reachedBottomOfList = true;
				arrowDownButton.setState(:stateDisabled);
		}
		else {
			reachedBottomOfList = false;
			arrowDownButton.setState(:stateDefault);
		}

		if(topOfVisibleList - 1 >= 0) {
			reachedTopOfList = false;
			arrowUpButton.setState(:stateDefault);
		}
		else {
			reachedTopOfList = true;
			arrowUpButton.setState(:stateDisabled);
		}
	}

	//Displays a single entry in the history list
	hidden function displayHistoryEntryColor(dc, listItem, screenPos) {
		var stateString = timeLogManager.getStateStringAt(listItem);
		dc.setColor( getColorByState(timeLogManager.getStateAt(listItem)),
			Graphics.COLOR_TRANSPARENT );
		dc.drawText( dc.getWidth() / 2, 80 + SPACE_BETWEEN_ENTRIES * screenPos,
			Graphics.FONT_SMALL, stateString, Graphics.TEXT_JUSTIFY_RIGHT |
			Graphics.TEXT_JUSTIFY_VCENTER );

		var curWorkTimeString = " " + timeLogManager.getTimeStringAt(listItem);
		dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
		dc.drawText( dc.getWidth() / 2 + 5, 80 + SPACE_BETWEEN_ENTRIES * screenPos,
			Graphics.FONT_SMALL, curWorkTimeString, Graphics.TEXT_JUSTIFY_LEFT |
			Graphics.TEXT_JUSTIFY_VCENTER );
	}

	//Returns the color that corresponds to the state
	public function getColorByState(state) {
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

	//Scrolls the history list so that the upper portions are visible
	public function scrollListUp() {
		WatchUi.requestUpdate(); //ensure 'reachedTopOfList' is updated
		if (!reachedTopOfList) {
			topOfVisibleList--;
		}
	}

	//Scrolls the history list so that the lower portions are visible
	public function scrollListDown() {
		WatchUi.requestUpdate(); //ensure 'reachedBottomOfList' is updated
		if (!reachedBottomOfList) {
			topOfVisibleList++;
		}
	}
}
