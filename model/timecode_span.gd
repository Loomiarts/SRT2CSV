# Pair of timecodes.
class_name TimecodeSpan
extends Reference

var start: Timecode = Timecode.new()

var end: Timecode = Timecode.new()

var string_value: String setget _set_string_value, _get_string_value


func offset(seconds_offset: float):
	start.seconds = max(start.seconds + seconds_offset, 0.0)
	end.seconds = max(end.seconds + seconds_offset, 0.0)


func duplicate() -> TimecodeSpan:
	var result = get_script().new()
	result.start.string_value = start.string_value
	result.end.string_value = end.string_value
	return result


func _set_string_value(s: String):
	var regex = RegEx.new()
	regex.compile("^(\\d\\d:\\d\\d:\\d\\d,\\d\\d\\d) --> (\\d\\d:\\d\\d:\\d\\d,\\d\\d\\d)$")
	var match_result = regex.search(s)
	if match_result.get_group_count() == 2:
		start = Timecode.new()
		start.string_value = match_result.strings[1]
		end = Timecode.new()
		end.string_value = match_result.strings[2]


func _get_string_value() -> String:
	return start.string_value + " --> " + end.string_value


func _to_string():
	return self.string_value
