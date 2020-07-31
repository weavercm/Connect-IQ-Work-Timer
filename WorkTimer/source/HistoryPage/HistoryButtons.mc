using Toybox.WatchUi;

//Handles the up arrow button in the History View
class ArrowUpButton extends WatchUi.Selectable {

	hidden var distanceFromTop;

	//Constructor
	public function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.arrowUpButton_highlighted});

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

	//Returns the distance from the top of the display to the
	//bottom of the button
	public function getDistanceFromTop() {
		return distanceFromTop;
	}

	//Performs an action when button is pressed
	public function performAction() {
		globalHistoryView.scrollListUp();
	}
}

//Handles the down arrow button in the History View
class ArrowDownButton extends WatchUi.Selectable {

	hidden var distanceFromBottom;

	//Constructor
	public function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.arrowDownButton_highlighted});

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

	//Returns the distance from the bottom of the display to the
	//top of the button
	public function getDistanceFromBottom() {
		return distanceFromBottom;
	}

	//Performs an action when button is pressed
	public function performAction() {
		globalHistoryView.scrollListDown();
	}
}

//Handles the back button in the History View
class BackButton extends WatchUi.Selectable {

	//Constructor
	public function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.backButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.backButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.backButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezID=>Rez.Drawables.backButton_highlighted});

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

	//Performs an action when button is pressed
	public function performAction() {
		HistoryDelegate.returnToWorkTimerView();
	}
}

//Handles the clear button in the History View
class XButton extends WatchUi.Selectable {

	//Constructor
	public function initialize(dc) {
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

	//Performs an action when button is pressed
	public static function performAction() {
		var message = "Clear History?";
		var dialog = new WatchUi.Confirmation(message);
		WatchUi.pushView(dialog, new ClearHistoryConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
	}
}
