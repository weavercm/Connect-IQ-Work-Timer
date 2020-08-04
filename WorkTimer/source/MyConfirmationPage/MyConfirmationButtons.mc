using Toybox.WatchUi;
using Toybox.Graphics;

//Handles the cancel button in the Confirmation View
class CancelButton extends WatchUi.Selectable {

	hidden var width = 50;
	hidden var height = 100;

	//Constructor
	public function initialize(dc)	{
		var buttonDefault = Graphics.COLOR_TRANSPARENT;
		var buttonHighlighted = Graphics.COLOR_TRANSPARENT;
		var buttonSelected = Graphics.COLOR_TRANSPARENT;
		var buttonDisabled = Graphics.COLOR_TRANSPARENT;

		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>dc.getWidth() * 0.25 - height / 2,
			:locY=>dc.getHeight() * 0.65 - width / 2,
			:width=>height,
			:height=>width
			};

		Selectable.initialize(settings);
	}
}

//Handles the confirm button in the Confirmation View
class ConfirmButton extends WatchUi.Selectable {

	hidden var width = 50;
	hidden var height = 100;

	//Constructor
	public function initialize(dc)	{
		var buttonDefault = Graphics.COLOR_TRANSPARENT;
		var buttonHighlighted = Graphics.COLOR_TRANSPARENT;
		var buttonSelected = Graphics.COLOR_TRANSPARENT;
		var buttonDisabled = Graphics.COLOR_TRANSPARENT;

		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>dc.getWidth() * 0.75 - height / 2,
			:locY=>dc.getHeight() * 0.65 - width / 2,
			:width=>height,
			:height=>width
			};

		Selectable.initialize(settings);
	}
}
