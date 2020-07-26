using Toybox.System;


//States the work timer can be in
public enum {

	OFF_CLOCK,
	ON_CLOCK,
	ON_BREAK
}

function intToStateEnum(int)
{
	switch(int)
	{
		case 0:
			return OFF_CLOCK;
		case 1:
			return ON_CLOCK;
		case 2:
			return ON_BREAK;
		default:
			return null;
	}
}

//Stores one history entry
class MyTimeHistoryUnit {

	var state;
	var time = new System.ClockTime();
	
	function initialize(state, time) {
		self.state = state;
		self.time = time;
	}
	
	function getStorageCompatableForm()
	{
		return [state, time.hour, time.min, time.sec];
	}
	
	function setFromStorageCompatableForm(storageCompatableArray)
	{
		state = storageCompatableArray[0];
		time.hour = storageCompatableArray[1];
		time.min = storageCompatableArray[2];
		time.sec = storageCompatableArray[3];
	}
	
	function getCopy()
	{
		var timeCopy = new System.ClockTime();
		timeCopy.hour = time.hour;
		timeCopy.min = time.min;
		timeCopy.sec = time.sec;
		
		return new MyTimeHistoryUnit(state, timeCopy);
	}
}

//manages the Work Timer's business logic
class MyTime {
	
	hidden var state = OFF_CLOCK;
	hidden var timeHistoryDict = {0=>1};
	public var currentDictKey = 0;
	
	function initialize(startTime)
	{
		timeHistoryDict.put(currentDictKey, 
			new MyTimeHistoryUnit(OFF_CLOCK, System.getClockTime()));
	}
	
	function clear()
	{
		timeHistoryDict = {0=>new MyTimeHistoryUnit(OFF_CLOCK, System.getClockTime())};
		currentDictKey = 0;
	}
	
	function getStorageCompatableDict()
	{
		var i;
		var storageCompatableDict = {};
		
		for( i = 0; i <= currentDictKey; i++)
		{
			storageCompatableDict.put(i, timeHistoryDict.get(i).getStorageCompatableForm());
		}
		
		return storageCompatableDict;
	}
	
	function setFromStorageCompatableDict(StorageCompatableDict)
	{
		var i;
		var singleHistoryEntry = new MyTimeHistoryUnit(OFF_CLOCK, new System.ClockTime());
		
		currentDictKey = StorageCompatableDict.size() - 1;
		timeHistoryDict = {};
		
		for( i = 0; i <= currentDictKey; i++)
		{
			singleHistoryEntry.setFromStorageCompatableForm(StorageCompatableDict.get(i));			
			timeHistoryDict.put(i, singleHistoryEntry.getCopy());
		}
	}
	
	function getTimeWorked()
	{
		var timeWorked = new System.ClockTime();
		timeWorked.hour = 0;
		timeWorked.min = 0;
		timeWorked.sec = 0;
		var i;

		var currentHist;
		var lastState;
		var lastTime;
		
		var curState;
		var curTime;
		
		if(currentDictKey >= 0)
		{
			currentHist = timeHistoryDict.get(0);
			lastState = currentHist.state;
			lastTime = currentHist.time;
			
			for (i = 1; i <= currentDictKey; i++)
			{
				currentHist = timeHistoryDict.get(i);
				curState = currentHist.state;
				curTime = currentHist.time;
				
				switch(lastState)
				{
					case ON_CLOCK:
						if(curState == OFF_CLOCK || curState == ON_BREAK)
						{
							timeWorked = addTimes(subtractTimes(curTime, lastTime), timeWorked);
							lastState = curState;
							lastTime = curTime;
						}
						break;
					case OFF_CLOCK:
					case ON_BREAK:
						if(curState == ON_CLOCK)
						{
							lastState = curState;
							lastTime = curTime;
						}
						break;
				}
			}
			
			if(curState == ON_CLOCK)
			{
				timeWorked = addTimes(subtractTimes(System.getClockTime(), curTime), timeWorked);
			}
		}
		
		return timeWorked;
	}
	
	hidden function getTimeOnBreak()
	{
	}
	
	
	
	function printEntireHistory()
	{
		System.println(getEntireHistoryString());
	}
	
	function printOneHistory(key)
	{
		System.println(getOneHistoryString(key));
	}
	
	function getEntireHistoryString()
	{
		var i = 0;
		var entireHistoryString = "History:\n";
		for(i = 0; i <= currentDictKey; i++)
		{
			entireHistoryString += "\t" + getOneHistoryString(i) + "\n";
		}
		
		return entireHistoryString;
	}
	
	function getStateAt(key)
	{
		var stateString = "";
		
		if(key <= currentDictKey)
		{	
			stateString = stateToString(timeHistoryDict.get(key).state);
		}
		
		return stateString;
	}
	
	function stateToString(state)
	{
		switch(state)
		{
			case ON_CLOCK:
				return "ON CLOCK";
			case OFF_CLOCK:
				return "OFF CLOCK";
			case ON_BREAK:
				return "ON BREAK";
		}
		
		return "null";
	}
	
	function getTimeAt(key)
	{
		var timeString = "";
		
		if(key <= currentDictKey)
		{
			var clockTime = timeHistoryDict.get(key).time;
			timeString = Lang.format("$1$:$2$:$3$", [clockTime.hour, clockTime.min.format("%02d"), clockTime.sec.format("%02d")]);		
		}
		
		return timeString;
	}
	
	function getOneHistoryString(key)
	{
		var oneHistoryString = "";
		
		if(key <= currentDictKey)
		{
			var clockTime = timeHistoryDict.get(key).time;
			var timeString = Lang.format("$1$:$2$:$3$", [clockTime.hour, clockTime.min.format("%02d"), clockTime.sec.format("%02d")]);		
			
			var stateString;
			switch(timeHistoryDict.get(key).state)
			{
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
	
	///// Getters and Setters /////	
	function setState(newState)
	{
		if(newState == state)
		{
			return;
		}
		
		currentDictKey++;
		timeHistoryDict.put(currentDictKey, new MyTimeHistoryUnit(newState, System.getClockTime()));
		
		state = newState;
	}
	
	function getState()
	{
		return state;
	}
}
