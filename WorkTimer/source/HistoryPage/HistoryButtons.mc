using Toybox.WatchUi;
using Toybox.Graphics;


//Handles the down arrow button in the History View
class ArrowDownButton extends SelectableWithDisable {

	hidden var distanceFromBottom;

	//Constructor
	public function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowDownButton_highlighted});
		var buttonDisabled = Graphics.COLOR_TRANSPARENT;

		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>(dc.getWidth() - buttonDefault.width) / 2,
			:locY=>dc.getHeight() - buttonDefault.height - 30,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};

		SelectableWithDisable.initialize(settings);

		distanceFromBottom = dc.getHeight() - locY;
	}

	//Returns the distance from the bottom of the display to the
	//top of the button
	public function getDistanceFromBottom() {
		return distanceFromBottom;
	}
}

//Handles the up arrow button in the History View
class ArrowUpButton extends SelectableWithDisable {

	hidden var distanceFromTop;

	//Constructor
	public function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.arrowUpButton_highlighted});
		var buttonDisabled = Graphics.COLOR_TRANSPARENT;

		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>(dc.getWidth() - buttonDefault.width) / 2,
			:locY=>35,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};

		SelectableWithDisable.initialize(settings);

		distanceFromTop = locY + height;
	}

	//Returns the distance from the top of the display to the
	//bottom of the button
	public function getDistanceFromTop() {
		return distanceFromTop;
	}
}

//Handles the clear button in the History View
class TrashButton extends SelectableWithDisable {

	//Constructor
	public function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.trashButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.trashButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.trashButton_highlighted});
		var buttonDisabled = Graphics.COLOR_TRANSPARENT;

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

		SelectableWithDisable.initialize(settings);
	}
}
