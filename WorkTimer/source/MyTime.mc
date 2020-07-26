using Toybox.System;

public enum
	{
		OFF_CLOCK,
		ON_CLOCK,
		ON_BREAK
	}


class MyTimeHistoryUnit
{	
	var state;
	var time;
	
	function initialize(state, time)
	{
		self.state = state;
		self.time = time;
	}
}

class MyTime
{	
	hidden var time;
	hidden var state = OFF_CLOCK;
	hidden var timeHistoryDict = {0=>1};
	public var currentDictKey = 0;
	
	
	function initialize(startTime)
	{
		time = startTime;
		timeHistoryDict.put(currentDictKey, new MyTimeHistoryUnit(OFF_CLOCK, System.getClockTime()));
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
	
//	function getTimeOnBreak()
//	{
//	}
	
	
	
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
		}
		
		return stateString;
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
	
	function increment()
	{
		switch(state)
		{
			case OFF_CLOCK:
				System.println("Off the clock; will not increment");
				break;
			case ON_CLOCK:
				System.println("On the clock; will increment");
				time++;
				break;
			case ON_BREAK:
				System.println("On break; will not increment");
				break;
			default:
				break;
		}
	}
	
	function setTime(newTime)
	{
		time = newTime;
	}
	
	function getTime()
	{
		return time;
	}
	
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
