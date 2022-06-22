# Pair of timecodes.
class_name TimecodeSpan
extends Reference

var start: Timecode = Timecode.new()

var end: Timecode = Timecode.new()


func offset(seconds_offset: float):
	var start_second = max(start.to_seconds() + seconds_offset, 0.0)
	var end_second = max(start.to_seconds() + seconds_offset, 0.0)
	start = Timecode.from_seconds(start_second)
	end = Timecode.from_seconds(end_second)


func duplicate() -> TimecodeSpan:
	var result = get_script().new()
	result.start.string_value = start.string_value
	result.end.string_value = end.string_value
	return result
