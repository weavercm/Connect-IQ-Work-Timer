using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Storage;

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
class TimeLogEntry {

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

	//Sets the time in seconds
	public function setTimeSec(newTime) {
		moment = new Time.Moment(newTime);
	}

	//Returns a copy of self
	public function getCopy() {
		return new TimeLogEntry(state, new Time.Moment(moment.value()));
	}

	//Returns the state and moment in a form that can be stored
	public function getStorageCompatableForm() {
		return [state, moment.value()];
	}

	//Sets the state and moment from a form that can be stored
	public function setFromStorageCompatableForm(storageCompatableArray) {
		state = storageCompatableArray[0];
		setTimeSec(storageCompatableArray[1]);
	}
}

class TimeLogManager {
	hidden var timeLogBook;

	public function initialize() {
		timeLogBook = new TimeLogBook();
	}

	public function clear() {
		timeLogBook.clear();
	}

	public function getLogBook() {
		return timeLogBook;
	}

	public function load() {
		timeLogBook.setFromStorageCompatableDict(Storage.getValue(USER_SAVE_ID));
	}

	public function save() {
		Storage.setValue(USER_SAVE_ID, timeLogBook.getStorageCompatableDict());
	}

	public function getSize() {
		return timeLogBook.getNumHistoryEntries();
	}

	public function setState(state) {
		timeLogBook.setState(state);
	}

	public function getState(key) {
		if(key != null && timeLogBook.isKeyValid(key)) {
			return timeLogBook.getStateAt(key);
		}
		else {
			return timeLogBook.getCurState();
		}
	}

	public function getTime(key) {
		if(key != null && timeLogBook.isKeyValid(key)) {
			return timeLogBook.getTimeAt(key);
		}
		else {
			return timeLogBook.getCurTime();
		}
	}

	//Returns a string
	public function getEntireHistoryString() {
		var i = 0;
		var entireHistoryString = "History:\n";
		for (i = 0; i <= curDictKey; i++) {
			entireHistoryString += "\t" + getOneHistoryString(i) + "\n";
		}

		return entireHistoryString;
	}

	public function getOneHistoryString(key) {
		var oneHistoryString = "";

		if(timeLogBook.isKeyValid(key)) {
			var moment = timeLogBook.getTimeAt(key);
			var timeInfo = Gregorian.info(moment, Time.FORMAT_SHORT);
			var timeString = Lang.format("$1$:$2$:$3$", [timeInfo.hour, timeInfo.min.format("%02d"), timeInfo.sec.format("%02d")]);

			var stateString = stateToString(timeLogBook.getStateAt(key));

			oneHistoryString = "History_" + key + ": " + "Time: " + timeString + ", State: " + stateString;
		}

		return oneHistoryString;
	}

	public function getStateStringAt(key) {
		var stateString = "";

		if(timeLogBook.isKeyValid(key)) {
			stateString = stateToString(timeLogBook.getStateAt(key));
		}

		return stateString;
	}

//	public function loadInTestData() {
//		var options2020 = {:year=>2020};
//		var options2021 = {:year=>2021};
//		timeHistoryDict = {
//			0=>new TimeLogEntry(OFF_CLOCK, Gregorian.moment(options2021)),
//			1=>new TimeLogEntry(ON_CLOCK, Gregorian.moment(options2021)),
//			2=>new TimeLogEntry(OFF_CLOCK, Gregorian.moment(options2021)),
//			3=>new TimeLogEntry(ON_CLOCK, Gregorian.moment(options2021)),
//			4=>new TimeLogEntry(OFF_CLOCK, Gregorian.moment(options2021)),
//			5=>new TimeLogEntry(ON_CLOCK, Gregorian.moment(options2021))
//		};
//
//		curDictKey = timeHistoryDict.size() - 1;
//		state = timeHistoryDict.get(curDictKey).state;
//	}

	public function getDateStringAt(key) {
		var timeString = "";

		if(timeLogBook.isKeyValid(key)) {
			var timeInfo = Gregorian.info(timeLogBook.getTimeAt(key), Time.FORMAT_SHORT);

			timeString = Lang.format("$1$/$2$/$3$", [timeInfo.month, timeInfo.day, timeInfo.year]);
		}

		return timeString;
	}

	public function printEntireHistory() {
		System.println(getEntireHistoryString());
	}

	public function printOneHistory(key) {
		System.println(getOneHistoryString(key));
	}

	public function getTimeStringAt(key) {
		var timeString = "";

		if(timeLogBook.isKeyValid(key)) {
			var timeInfo = Gregorian.info(timeLogBook.getTimeAt(key), Time.FORMAT_SHORT);
			timeString = Lang.format("$1$:$2$:$3$", [timeInfo.hour, timeInfo.min.format("%02d"), timeInfo.sec.format("%02d")]);
		}

		return timeString;
	}


}


//Manages the Work Timer's business logic
class TimeLogBook {

	hidden var state = OFF_CLOCK;
	hidden var timeHistoryDict = {0=>1};
	hidden var curDictKey = 0;

	//Constructor
	public function initialize() {
		timeHistoryDict.put(curDictKey, new TimeLogEntry(OFF_CLOCK, Time.now()));
	}

	public function isKeyValid(key) {
		return (key <= curDictKey) && (key >= 0);
	}

	//Clears the history
	public function clear() {
		timeHistoryDict = {0=>new TimeLogEntry(OFF_CLOCK, Time.now())};
		state = OFF_CLOCK;
		curDictKey = 0;
	}

	//Returns the number of recorded history entries
	public function getNumHistoryEntries() {
		return timeHistoryDict.size() - 1;
	}

	public function getCurState() {
		return state;
	}

	public function getStateAt(key) {
		if(key <= curDictKey) {
			return timeHistoryDict.get(key).state;
		}

		return null;
	}

	public function getStorageCompatableDict() {
		var i;
		var storageCompatableDict = {};

		for (i = 0; i <= curDictKey; i++) {
			storageCompatableDict.put(i, timeHistoryDict.get(i).getStorageCompatableForm());
		}

		return storageCompatableDict;
	}

	public function getTimeAt(key) {
		if(key <= curDictKey) {
			return timeHistoryDict.get(key).moment;
		}

		return null;
	}

	public function getCurTime() {
		return timeHistoryDict.get(curDictKey).moment;
	}

	public function getTimeWorked() {
		var timeWorked = new Time.Duration(0);
		var i;

		var currentHist;
		var lastState;
		var lastTime;

		var curState;
		var curTime;

		if (curDictKey >= 0) {

			currentHist = timeHistoryDict.get(0);
			lastState = currentHist.state;
			lastTime = currentHist.moment;

			for (i = 1; i <= curDictKey; i++) {
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

	public function setFromStorageCompatableDict(StorageCompatableDict) {
		var i;
		var singleHistoryEntry = new TimeLogEntry(OFF_CLOCK, new Time.Moment(0));

		curDictKey = StorageCompatableDict.size() - 1;
		timeHistoryDict = {};

		for( i = 0; i <= curDictKey; i++) {
			singleHistoryEntry.setFromStorageCompatableForm(StorageCompatableDict.get(i));
			timeHistoryDict.put(i, singleHistoryEntry.getCopy());
		}

		state = timeHistoryDict.get(curDictKey).state;
	}

	public function setState(newState) {
		if(newState == state) {
			return;
		}

		curDictKey++;
		timeHistoryDict.put(curDictKey, new TimeLogEntry(newState, Time.now()));

		state = newState;
	}
}
