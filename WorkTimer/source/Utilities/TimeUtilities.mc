using Toybox.Lang;
using Toybox.Time.Gregorian;

class TimeUtilities {

	//Returns a string containing GregorianInfo information in a readable format
	public static function getTimeReadable(moment) {
		var gregInfo = momentToGregInfo(moment);
		var timeString = Lang.format("$1$:$2$:$3$", [gregInfo.hour,
			gregInfo.min.format("%02d"), gregInfo.sec.format("%02d")]);

		return timeString;
	}

	//Converts a Moment into (days,) hours, mins, and secs
	public static function momentToGregInfo(moment) {
		var gregInfo = new Gregorian.Info();
		/*Uncomment to include days
		gregInfo.day = moment.value() / Gregorian.SECONDS_PER_DAY;
		gregInfo.hour = (moment.value() % Gregorian.SECONDS_PER_DAY) / Gregorian.SECONDS_PER_HOUR;
		*/
		//Comment to get days
		gregInfo.hour = moment.value() / Gregorian.SECONDS_PER_HOUR;
		//

		gregInfo.min = (moment.value() % Gregorian.SECONDS_PER_HOUR) / Gregorian.SECONDS_PER_MINUTE;
		gregInfo.sec = (moment.value() % Gregorian.SECONDS_PER_MINUTE);

		return gregInfo;
	}
}