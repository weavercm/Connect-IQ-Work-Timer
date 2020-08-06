using Toybox.System;
using Toybox.Math;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Storage;


//Contains and manages a number of TimeLogEntries
class TimeLogBook {

	hidden var state = TimeLogEntry.OFF_CLOCK;
	hidden var logEntryDict = {0=>1};
	hidden var curDictKey = 0;

	//Constructor
	public function initialize() {
		logEntryDict.put(curDictKey, new TimeLogEntry(TimeLogEntry.OFF_CLOCK, Time.now()));
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

	public function loadInRandomTestData(numEntries) {
		Math.srand(Time.now().value());
		var baseYear = Math.rand() % 5 + 2014;
		var baseMonth = Math.rand() % 11 + 1;
		var baseDay = Math.rand() % 30 + 1;
		var baseHour = Math.rand() % 23;
		var baseMin = Math.rand() % 59;
		var baseSec = Math.rand() % 59;
		var baseState = TimeLogEntry.OFF_CLOCK;

		var i = 0;
		var options = {:year=>baseYear, :month=>baseMonth, :day=>baseDay, :hour=>baseHour, :minute=>baseMin, :second=>baseSec};
		var curMoment = Gregorian.moment(options);
		var dict = {0=>(new TimeLogEntry(baseState, curMoment))};


		for(i = 1; i <= numEntries; i++) {
			curMoment = new Time.Moment(curMoment.value() + Math.rand() % Gregorian.SECONDS_PER_DAY);
			switch(Math.rand() % 3) {
				case 0:
					baseState = TimeLogEntry.OFF_CLOCK;
					break;
				case 1:
					baseState = TimeLogEntry.ON_CLOCK;
					break;
				case 2:
					baseState = TimeLogEntry.ON_BREAK;
					break;
			}
			dict.put(i, new TimeLogEntry(baseState, curMoment));
		}

		logEntryDict = dict;
		curDictKey = logEntryDict.size() - 1;
		state = logEntryDict.get(curDictKey).state;
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
}

//Stores one log entry
class TimeLogEntry {

	//States the Time Log Entry can be in
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

	//Returns a copy of self
	public function getCopy() {
		return new TimeLogEntry(state, new Time.Moment(moment.value()));
	}

	//Returns the state and moment in a form that can be stored
	public function getStorageCompatableForm() {
		return [state, moment.value()];
	}

	//Gets the time in seconds
	public function getTimeSec() {
		return moment.value();
	}

	//Sets the state and moment from a form that can be stored
	public function setFromStorageCompatableForm(storageCompatableArray) {
		state = storageCompatableArray[0];
		setTimeSec(storageCompatableArray[1]);
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

	//Add TimeLogEntry to timeLogBook
	public function addEntry(state) {
		timeLogBook.addState(state);
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
		for (i = 0; i <= getSize(); i++) {
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

	//Returns a Moment stored in the timeLogBook at 'key'
	public function getTime(key) {
		return timeLogBook.getTimeAt(key);
	}

	//Returns a string representing a Moment stored in the timeLogBook at 'key'
	public function getTimeStringAt(key) {
		var timeString = "";

		if(timeLogBook.isKeyValid(key)) {
			var timeInfo = Gregorian.info(timeLogBook.getTimeAt(key), Time.FORMAT_SHORT);
			timeString = Lang.format("$1$:$2$:$3$", [timeInfo.hour, timeInfo.min.format("%02d"), timeInfo.sec.format("%02d")]);
		}

		return timeString;
	}

	//Returns the total amount of time that ON_CLOCK has been the current state
	public function getTimeWorked() {
		var timeWorked = new Time.Duration(0);
		var i;
		var lastState = TimeLogEntry.OFF_CLOCK;
		var lastTime = new Time.Moment(0);
		var curState = TimeLogEntry.OFF_CLOCK;
		var curTime = new Time.Moment(0);

		//Add up intervals that current state is ON_CLOCK
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

		return timeWorked;
	}

	//Loads in a TimeLogBook from device storage
	public function load() {
		timeLogBook.setFromStorageCompatableDict(Storage.getValue(saveID));
	}

	public function loadInRandomTestData(numEntries) {
		timeLogBook.loadInRandomTestData(numEntries);
		printLogBook();
	}

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
}
