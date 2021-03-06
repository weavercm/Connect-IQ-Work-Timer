using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics;


//Handles the break button in the Work Timer View
class BreakButton extends SelectableWithDisable {

	//Constructor
	function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.breakButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.breakButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.breakButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezId=>Rez.Drawables.breakButton_disabled});

		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>(dc.getWidth() - buttonDefault.width) / 2,
			:locY=>dc.getHeight() - buttonDefault.height - 5,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};

		SelectableWithDisable.initialize(settings);
	}
}

//Handles the clock in button in the Work Timer View
class ClockInButton extends SelectableWithDisable {

	//Constructor
	public function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockInButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockInButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockInButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockInButton_disabled});

		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>10,
			:locY=>dc.getHeight() - 2 * buttonDefault.height - 5,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};

		SelectableWithDisable.initialize(settings);
	}
}

//Handles the clock out button in the Work Timer View
class ClockOutButton extends SelectableWithDisable {

	//Constructor
	public function initialize(dc)	{
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOutButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOutButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOutButton_highlighted});
		var buttonDisabled = new WatchUi.Bitmap({:rezId=>Rez.Drawables.clockOutButton_disabled});

		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>dc.getWidth() - buttonDefault.width - 10,
			:locY=>dc.getHeight() - 2 * buttonDefault.height - 5,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};

		SelectableWithDisable.initialize(settings);
	}
}

//Handles the history button in the Work Timer View
class HistoryButton extends SelectableWithDisable {

	//Constructor
	function initialize(dc) {
		var buttonDefault = new WatchUi.Bitmap({:rezId=>Rez.Drawables.historyButton_default});
		var buttonHighlighted = new WatchUi.Bitmap({:rezId=>Rez.Drawables.historyButton_highlighted});
		var buttonSelected = new WatchUi.Bitmap({:rezId=>Rez.Drawables.historyButton_default});
		var buttonDisabled = new WatchUi.Bitmap({:rezId=>Rez.Drawables.historyButton_default});

		var settings = {
			:stateDefault=>buttonDefault,
			:stateHighlighted=>buttonHighlighted,
			:stateSelected=>buttonHighlighted,
			:stateDisabled=>buttonDisabled,
			:locX=>(dc.getWidth() - buttonDefault.width) / 2,
			:locY=>(dc.getHeight() / 2) - buttonDefault.height + 5,
			:width=>buttonDefault.width,
			:height=>buttonDefault.height
			};

		SelectableWithDisable.initialize(settings);
	}
}
