using Toybox.WatchUi;


//Easily handles if a selectable is in the disabled state
class SelectableWithDisable extends WatchUi.Selectable {

	//Constructor
	public function initialize(settings) {
		Selectable.initialize(settings);
	}

	//Will only execute 'methodToCall' if has not recently been in disabled state
	public function handleEvent(prevState, methodToCall) {
		if(prevState == :stateDisabled || getState() == :stateDisabled) {
			setState(:stateDisabled);
			return;
		}
		if(getState() == :stateSelected) {
			methodToCall.invoke();
		}
	}

	//Disables or enables (any state other than :stateDisabled) the selectable
	public function setEnable(isEnabled) {
		if(isEnabled && getState() == :stateDisabled) {
			setState(:stateDefault);
		}
		else if(!isEnabled) {
			setState(:stateDisabled);
		}
	}
}