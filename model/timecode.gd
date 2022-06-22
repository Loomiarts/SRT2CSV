# Represents a timecode formatted as hh:MM:ss,mmm.
class_name Timecode
extends Reference

var string_value = "00:00:00,000"


func _to_string():
	return string_value


func to_seconds() -> float:
	return 0.0


static func from_seconds(seconds: float) -> Timecode:
	var result = load("model/Timecode").new()
	return result
