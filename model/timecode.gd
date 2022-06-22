# Represents a timecode formatted as hh:MM:ss,mmm.
class_name Timecode
extends Reference

var string_value = "00:00:00,000"

var seconds: float setget _set_seconds, _get_seconds


func _to_string():
	return string_value


func _set_seconds(s: float):
	var seconds_integer = int(s)
	var hours_component = min((seconds_integer / 60 / 60), 99)
	var minutes_component = (seconds_integer / 60) % 60
	var seconds_component = seconds_integer % 60
	var frac_component = int(fmod(s, 1.0) * 1000.0)
	string_value = "%02d:%02d:%02d,%03d" % [hours_component, minutes_component, seconds_component, frac_component]


func _get_seconds() -> float:
	var regex = RegEx.new()
	regex.compile("^(\\d\\d):(\\d\\d):(\\d\\d),(\\d\\d\\d)$")
	var match_result = regex.search(string_value)
	if match_result.get_group_count() != 4:
		return 0.0
	else:
		var hours = int(match_result.strings[1])
		var minutes = int(match_result.strings[2])
		var seconds = int(match_result.strings[3])
		var frac = int(match_result.strings[4])
		return float(seconds + (minutes * 60) + (hours * 60 * 60)) + (float(frac) / 1000.0);
