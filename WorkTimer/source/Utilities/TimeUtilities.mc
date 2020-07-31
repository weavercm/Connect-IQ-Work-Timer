using Toybox.Lang;

//Returns a string containing GregorianInfo information in a readable format
function getTimeReadable(gregorianInfo) {
	var timeString = Lang.format("$1$:$2$:$3$", [gregorianInfo.hour,
		gregorianInfo.min.format("%02d"), gregorianInfo.sec.format("%02d")]);

	return timeString;
}