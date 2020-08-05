using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Storage;


//Stores one log entry
class TimeLogEntry {

	//States the Work Timer can be in
	public enum {
		OFF_CLOCK,
		ON_CLOCK,
		ON_BREAK
	}

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

	//Returns a string representing a 'state'
	public static function timeStateToString(state) {
		switch(state) {
			case TimeLogEntry.ON_CLOCK:
				return "ON CLOCK";
			case TimeLogEntry.OFF_CLOCK:
				return "OFF CLOCK";
			case TimeLogEntry.ON_BREAK:
				return "ON BREAK";
		}

		return "null";
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

//This adds extra functionality to the timeLogBook
class TimeLogManager {

	hidden var saveID = "";
	hidden var timeLogBook;

	//Constructor
	public function initialize(saveID) {
		self.saveID = saveID;
		timeLogBook = new TimeLogBook();
	}

	//Clears the timeLogBook
	public function clear() {
		timeLogBook.clear();
	}

	//Returns the current state
	public function getCurState() {
		return timeLogBook.getCurState();
	}

	//Returns the current time
	public function getCurTime() {
		return timeLogBook.getCurTime();
	}

	//Returns a string representing the date for an entry
	public function getDateStringAt(key) {
		var timeString = "";

		if(timeLogBook.isKeyValid(key)) {
			var timeInfo = Gregorian.info(timeLogBook.getTimeAt(key), Time.FORMAT_SHORT);

			timeString = Lang.format("$1$/$2$/$3$", [timeInfo.month, timeInfo.day, timeInfo.year]);
		}

		return timeString;
	}

	//Returns a string displaying the stored timeLogBook data
	public function getLogBookString() {
		var i = 0;
		var logBookString = "Log:\n";
		for (i = 0; i <= curDictKey; i++) {
			logBookString += "\t" + getLogEntryStringAt(i) + "\n";
		}

		return logBookString;
	}

	//Returns a string displaying a single timeLogEntry at 'key'
	public function getLogEntryStringAt(key) {
		var logEntryString = "";

		if(timeLogBook.isKeyValid(key)) {
			var moment = timeLogBook.getTimeAt(key);
			var timeInfo = Gregorian.info(moment, Time.FORMAT_SHORT);
			var timeString = Lang.format("$1$:$2$:$3$", [timeInfo.hour, timeInfo.min.format("%02d"), timeInfo.sec.format("%02d")]);

			var stateString = TimeLogEntry.timeStateToString(timeLogBook.getStateAt(key));

			logEntryString = key + ": " + "Time: " + timeString + ", State: " + stateString;
		}

		return logEntryString;
	}

	//Returns the number of entries in the timeLogBook
	public function getSize() {
		return timeLogBook.getNumLogEntries();
	}

	//Returns the state at 'key'
	public function getStateAt(key) {
		return timeLogBook.getStateAt(key);
	}

	//Returns a string displaying the state at 'key'
	public function getStateStringAt(key) {
		var stateString = "";

		if(timeLogBook.isKeyValid(key)) {
			stateString = TimeLogEntry.timeStateToString(timeLogBook.getStateAt(key));
		}

		return stateString;
	}

	//Returns a Moment stored in the timeLogEntry at 'key'
	public function getTime(key) {
		return timeLogBook.getTimeAt(key);
	}

	//Returns a string representing a Moment stored in the timeLogEntry at 'key'
	public function getTimeStringAt(key) {
		var timeString = "";

		if(timeLogBook.isKeyValid(key)) {
			var timeInfo = Gregorian.info(timeLogBook.getTimeAt(key), Time.FORMAT_SHORT);
			timeString = Lang.format("$1$:$2$:$3$", [timeInfo.hour, timeInfo.min.format("%02d"), timeInfo.sec.format("%02d")]);
		}

		return timeString;
	}

	//Returns the total amount of time that CLOCK_IN has been the current state
	public function getTimeWorked() {
		var timeWorked = new Time.Duration(0);
		var i;
		var lastState = TimeLogEntry.OFF_CLOCK;
		var lastTime = new Time.Moment(0);
		var curState = TimeLogEntry.OFF_CLOCK;
		var curTime = new Time.Moment(0);

		for (i = 1; i <= timeLogBook.getNumLogEntries(); i++) {
			curState = timeLogBook.getStateAt(i);
			curTime = timeLogBook.getTimeAt(i);

			switch (lastState) {
				case TimeLogEntry.ON_CLOCK:
					if (curState == TimeLogEntry.OFF_CLOCK || curState == TimeLogEntry.ON_BREAK) {
						timeWorked = timeWorked.add(curTime.subtract(lastTime));
						lastState = curState;
						lastTime = curTime;
					}
					break;
				case TimeLogEntry.OFF_CLOCK:
				case TimeLogEntry.ON_BREAK:
					if (curState == TimeLogEntry.ON_CLOCK) {
						lastState = curState;
						lastTime = curTime;
					}
					break;
			}
		}

		if (curState == TimeLogEntry.ON_CLOCK) {
			timeWorked = timeWorked.add(Time.now().subtract(curTime));
		}

		var gregTime = new Gregorian.Info();
		gregTime.day = timeWorked.value() / Gregorian.SECONDS_PER_DAY;
		gregTime.hour = (timeWorked.value() % Gregorian.SECONDS_PER_DAY) / Gregorian.SECONDS_PER_HOUR;
		gregTime.min = (timeWorked.value() % Gregorian.SECONDS_PER_HOUR) / Gregorian.SECONDS_PER_MINUTE;
		gregTime.sec = (timeWorked.value() % Gregorian.SECONDS_PER_MINUTE);

		return gregTime;
	}

	//Loads in a TimeLogBook from device storage
	public function load() {
		timeLogBook.setFromStorageCompatableDict(Storage.getValue(saveID));
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

	//Prints out the contents of the timeLogBook in a readable format
	public function printLogBook() {
		System.println(getLogBookString());
	}

	//Prints out a TimeLogEntry at index 'key' of timeLogBook in a readable format
	public function printLogEntryAt(key) {
		System.println(getLogEntryStringAt(key));
	}

	//Stores the timeLogBook into device storage
	public function save() {
		Storage.setValue(saveID, timeLogBook.getStorageCompatableDict());
	}

	//Add TimeLogEntry to timeLogBook
	public function addEntry(state) {
		timeLogBook.addState(state);
	}
}


//Contains and manages a number of TimeLogEntries
class TimeLogBook {

	hidden var state = TimeLogEntry.OFF_CLOCK;
	hidden var logEntryDict = {0=>1};
	hidden var curDictKey = 0;

	//Constructor
	public function initialize() {
		logEntryDict.put(curDictKey, new TimeLogEntry(TimeLogEntry.OFF_CLOCK, Time.now()));
	}

	//Clears the log book
	public function clear() {
		logEntryDict = {0=>new TimeLogEntry(TimeLogEntry.OFF_CLOCK, Time.now())};
		state = TimeLogEntry.OFF_CLOCK;
		curDictKey = 0;
	}

	//Returns the current state
	public function getCurState() {
		return state;
	}

	//Returns the current Moment
	public function getCurTime() {
		return logEntryDict.get(curDictKey).moment;
	}

	//Returns the number of recorded log entries
	public function getNumLogEntries() {
		return logEntryDict.size() - 1;
	}

	//Returns the state at 'key'
	public function getStateAt(key) {
		if(isKeyValid(key)) {
			return logEntryDict.get(key).state;
		}

		return null;
	}

	//Returns a Dictionary containing the entire log in a format that can be stored
	public function getStorageCompatableDict() {
		var i;
		var storageCompatableDict = {};

		for (i = 0; i <= curDictKey; i++) {
			storageCompatableDict.put(i, logEntryDict.get(i).getStorageCompatableForm());
		}

		return storageCompatableDict;
	}

	//Returns the time at 'key'
	public function getTimeAt(key) {
		if(isKeyValid(key)) {
			return logEntryDict.get(key).moment;
		}

		return null;
	}

	//Returns true if the key is valid, false otherwise
	public function isKeyValid(key) {
		return (key <= curDictKey) && (key > 0);
	}

	//Populates the logBook from a Dictionary containing the entire log in a format that can be stored
	public function setFromStorageCompatableDict(StorageCompatableDict) {
		var i;
		var logEntry = new TimeLogEntry(TimeLogEntry.OFF_CLOCK, new Time.Moment(0));

		curDictKey = StorageCompatableDict.size() - 1;
		logEntryDict = {};

		for( i = 0; i <= curDictKey; i++) {
			logEntry.setFromStorageCompatableForm(StorageCompatableDict.get(i));
			logEntryDict.put(i, logEntry.getCopy());
		}

		state = logEntryDict.get(curDictKey).state;
	}

	//Adds an entry to the log book
	public function addState(newState) {
		if(newState == state) {
			return;
		}

		curDictKey++;
		logEntryDict.put(curDictKey, new TimeLogEntry(newState, Time.now()));

		state = newState;
	}
}
