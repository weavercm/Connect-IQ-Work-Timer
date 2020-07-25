using Toybox.System;
using Toybox.Math;

function secToClockTime(seconds)
	{
		var clockTime = new System.ClockTime();
		clockTime.hour = Math.round(seconds / 3600);
		clockTime.min = Math.round((seconds % 3600) / 60);
		clockTime.sec = Math.round(seconds % 60);
		
		return clockTime;
	}
	
	function clockTimeToSec(clockTime)
	{
		return clockTime.hour * 3600 + clockTime.min * 60 + clockTime.sec;
	}
	
	function subtractTimes(time1, time2)
	{
		var timeInSec1 = clockTimeToSec(time1);
		var timeInSec2 = clockTimeToSec(time2);
		var timeDifference = timeInSec1 - timeInSec2;
		
		return secToClockTime(timeDifference);
	}
	
	function addTimes(time1, time2)
	{
		var timeInSec1 = clockTimeToSec(time1);
		var timeInSec2 = clockTimeToSec(time2);
		var timeSum = timeInSec1 + timeInSec2;
		
		return secToClockTime(timeSum);
	}