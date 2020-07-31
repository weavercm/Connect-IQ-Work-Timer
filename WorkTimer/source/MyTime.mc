using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

//States the Work Timer can be in
public enum {
	OFF_CLOCK,
	ON_CLOCK,
	ON_BREAK
}

function stateToString(state) {
	switch(state) {
		case ON_CLOCK:
			return "ON CLOCK";
		case OFF_CLOCK:
			return "OFF CLOCK";
		case ON_BREAK:
			return "ON BREAK";
	}

	return "null";
}

//Stores one history entry
class MyTimeHistoryUnit {

	public var state;
	public var moment = new Time.Moment(0);

	//Constructor
	public function initialize(state, moment) {
		self.state = state;
		self.moment = moment;
	}

	//Gets the time in seconds
	public function getTimeSec() {
		return moment.value();
	}

	//Sets the moment
	public function setTime(newTime) {
		moment = new Time.Moment(newTime);
	}

	//Returns a copy of self
	public function getCopy() {
		return new MyTimeHistoryUnit(state, new Time.Moment(moment.value()));
	}

	//Returns the state and moment in a form that can be stored
	public function getStorageCompatableForm() {
		return [state, moment.value()];
	}

	//Sets the state adn moment using a form that can be stored
	public function setFromStorageCompatableForm(storageCompatableArray) {
		state = storageCompatableArray[0];
		setTime(storageCompatableArray[1]);
	}
}

//Manages the Work Timer's business logic
class MyTime {

	hidden var state = OFF_CLOCK;
	hidden var timeHistoryDict = {0=>1};
	hidden var currentDictKey = 0;

	//Constructor
	public function initialize() {
		timeHistoryDict.put(currentDictKey, new MyTimeHistoryUnit(OFF_CLOCK, Time.now()));
	}

	//Clears the history
	public function clear() {
		timeHistoryDict = {0=>new MyTimeHistoryUnit(OFF_CLOCK, Time.now())};
		state = OFF_CLOCK;
		currentDictKey = 0;
	}

	//Returns the number of recorded history entries
	public function getNumHistoryEntries() {
		return timeHistoryDict.size() - 1;
	}

	//Returns a string
	public function getEntireHistoryString() {
		var i = 0;
		var entireHistoryString = "History:\n";
		for (i = 0; i <= currentDictKey; i++) {
			entireHistoryString += "\t" + getOneHistoryString(i) + "\n";
		}

		return entireHistoryString;
	}

	public function getOneHistoryString(key) {
		var oneHistoryString = "";

		if(key <= currentDictKey) {
			var moment = timeHistoryDict.get(key).moment;
			var timeInfo = Gregorian.info(moment, Time.FORMAT_SHORT);
			var timeString = Lang.format("$1$:$2$:$3$", [timeInfo.hour, timeInfo.min.format("%02d"), timeInfo.sec.format("%02d")]);

			var stateString;
			switch(timeHistoryDict.get(key).state) {
				case ON_CLOCK:
					stateString = "ON_CLOCK";
					break;
				case OFF_CLOCK:
					stateString = "OFF_CLOCK";
					break;
				case ON_BREAK:
					stateString = "ON_BREAK";
					break;
			}
			oneHistoryString = "History_" + key + ": " + "Time: " + timeString + ", State: " + stateString;
		}

		return oneHistoryString;
	}

	public function getState() {
		return state;
	}

	public function getStateAt(key) {
		if(key <= currentDictKey) {
			return timeHistoryDict.get(key).state;
		}

		return null;
	}

	public function getStateStringAt(key) {
		var stateString = "";

		if(key <= currentDictKey) {
			stateString = stateToString(timeHistoryDict.get(key).state);
		}

		return stateString;
	}

	public function getStorageCompatableDict() {
		var i;
		var storageCompatableDict = {};

		for (i = 0; i <= currentDictKey; i++) {
			storageCompatableDict.put(i, timeHistoryDict.get(i).getStorageCompatableForm());
		}

		return storageCompatableDict;
	}

	public function getTimeAt(key) {
		var timeString = "";

		if(key <= currentDictKey) {
			var timeInfo = Gregorian.info(timeHistoryDict.get(key).moment, Time.FORMAT_SHORT);
			timeString = Lang.format("$1$:$2$:$3$", [timeInfo.hour, timeInfo.min.format("%02d"), timeInfo.sec.format("%02d")]);
		}

		return timeString;
	}

	public function loadInTestData() {
		var options2020 = {:year=>2020};
		var options2021 = {:year=>2021};
		timeHistoryDict = {
			0=>new MyTimeHistoryUnit(OFF_CLOCK, Gregorian.moment(options2021)),
			1=>new MyTimeHistoryUnit(ON_CLOCK, Gregorian.moment(options2021)),
			2=>new MyTimeHistoryUnit(OFF_CLOCK, Gregorian.moment(options2021)),
			3=>new MyTimeHistoryUnit(ON_CLOCK, Gregorian.moment(options2021)),
			4=>new MyTimeHistoryUnit(OFF_CLOCK, Gregorian.moment(options2021)),
			5=>new MyTimeHistoryUnit(ON_CLOCK, Gregorian.moment(options2021))
		};

		currentDictKey = timeHistoryDict.size() - 1;
		state = timeHistoryDict.get(currentDictKey).state;
	}

	public function getDateStringAt(key) {
		var timeString = "";

		if(key <= currentDictKey) {
			var timeInfo = Gregorian.info(timeHistoryDict.get(key).moment, Time.FORMAT_SHORT);

			timeString = Lang.format("$1$/$2$/$3$", [timeInfo.month, timeInfo.day, timeInfo.year]);
		}

		return timeString;
	}

	public function getTimeWorked() {
		var timeWorked = new Time.Duration(0);
		var i;

		var currentHist;
		var lastState;
		var lastTime;

		var curState;
		var curTime;

		if (currentDictKey >= 0) {

			currentHist = timeHistoryDict.get(0);
			lastState = currentHist.state;
			lastTime = currentHist.moment;

			for (i = 1; i <= currentDictKey; i++) {
				currentHist = timeHistoryDict.get(i);
				curState = currentHist.state;
				curTime = currentHist.moment;

				switch (lastState) {
				case ON_CLOCK:
					if (curState == OFF_CLOCK || curState == ON_BREAK) {
						timeWorked = timeWorked.add(curTime.subtract(lastTime));
						lastState = curState;
						lastTime = curTime;
					}
					break;
				case OFF_CLOCK:
				case ON_BREAK:
					if (curState == ON_CLOCK) {
						lastState = curState;
						lastTime = curTime;
					}
					break;
				}
			}

			if (curState == ON_CLOCK) {
				timeWorked = timeWorked.add(Time.now().subtract(curTime));
			}
		}

		var gregTime = new Gregorian.Info();
		gregTime.day = timeWorked.value() / Gregorian.SECONDS_PER_DAY;
		gregTime.hour = (timeWorked.value() % Gregorian.SECONDS_PER_DAY) / Gregorian.SECONDS_PER_HOUR;
		gregTime.min = (timeWorked.value() % Gregorian.SECONDS_PER_HOUR) / Gregorian.SECONDS_PER_MINUTE;
		gregTime.sec = (timeWorked.value() % Gregorian.SECONDS_PER_MINUTE);

		return gregTime;
	}

	public function printEntireHistory() {
		System.println(getEntireHistoryString());
	}

	public function printOneHistory(key) {
		System.println(getOneHistoryString(key));
	}

	public function setFromStorageCompatableDict(StorageCompatableDict) {
		var i;
		var singleHistoryEntry = new MyTimeHistoryUnit(OFF_CLOCK, new Time.Moment(0));

		currentDictKey = StorageCompatableDict.size() - 1;
		timeHistoryDict = {};

		for( i = 0; i <= currentDictKey; i++) {
			singleHistoryEntry.setFromStorageCompatableForm(StorageCompatableDict.get(i));
			timeHistoryDict.put(i, singleHistoryEntry.getCopy());
		}

		state = timeHistoryDict.get(currentDictKey).state;
	}

	public function setState(newState) {
		if(newState == state) {
			return;
		}

		currentDictKey++;
		timeHistoryDict.put(currentDictKey, new MyTimeHistoryUnit(newState, Time.now()));

		state = newState;
	}
}
