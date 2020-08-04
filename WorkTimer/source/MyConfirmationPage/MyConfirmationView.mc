using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;


//Handles the ConfirmationView
class MyConfirmationView extends WatchUi.View {

	hidden var cancelButton = null;
	hidden var confirmButton = null;
	hidden var message = "";

	//Constructor
	function initialize(message) {
		self.message = message;
		View.initialize();
	}

	//Called before displaying graphics. Loads resources here.
	function onLayout(dc) {
		cancelButton = new CancelButton(dc);
		confirmButton = new ConfirmButton(dc);

		setLayout([cancelButton, confirmButton]);
	}

	//Updates the view
	function onUpdate(dc) {
		View.onUpdate(dc);

	    dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
	    //Display message
	    dc.drawText( dc.getWidth() / 2, dc.getHeight() * 0.30, Graphics.FONT_MEDIUM,
	    	message, Graphics.TEXT_JUSTIFY_CENTER |
	    	Graphics.TEXT_JUSTIFY_VCENTER );
		//"Cancel"
	    dc.drawText( dc.getWidth() * 0.25, dc.getHeight() * 0.65,
	    	Graphics.FONT_MEDIUM, "Cancel",
	    	Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
	    //"Confirm"
	    dc.drawText( dc.getWidth() * 0.75, dc.getHeight() * 0.65,
	    	Graphics.FONT_MEDIUM, "Confirm",
	    	Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
	}
}
