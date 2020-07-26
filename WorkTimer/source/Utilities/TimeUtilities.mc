using Toybox.System;
using Toybox.Math;
using Toybox.Lang;

//Converts seconds to a ClockTime object
function secToClockTime(seconds)
{
	var clockTime = new System.ClockTime();
	clockTime.hour = Math.round(seconds / 3600);
	clockTime.min = Math.round((seconds % 3600) / 60);
	clockTime.sec = Math.round(seconds % 60);
	
	return clockTime;
}

//Converts a ClockTime object to seconds
function clockTimeToSec(clockTime)
{
	return clockTime.hour * 3600 + clockTime.min * 60 + clockTime.sec;
}

//Subtracts two ClockTime objects
function subtractTimes(time1, time2)
{
	var timeInSec1 = clockTimeToSec(time1);
	var timeInSec2 = clockTimeToSec(time2);
	var timeDifference = timeInSec1 - timeInSec2;
	
	return secToClockTime(timeDifference);
}

//Adds two ClockTime objects
function addTimes(time1, time2)
{
	var timeInSec1 = clockTimeToSec(time1);
	var timeInSec2 = clockTimeToSec(time2);
	var timeSum = timeInSec1 + timeInSec2;
	
	return secToClockTime(timeSum);
}

//Returns a string containing ClockTime information in a readable format
function getTimeReadable(clockTime)
{
	var timeString = Lang.format("$1$:$2$:$3$", [clockTime.hour, 
		clockTime.min.format("%02d"), clockTime.sec.format("%02d")]);
			
	return timeString;
}