# Model for a subtitle line of a .srt file.
class_name SRTSubtitle
extends Reference

var time: TimecodeSpan = TimecodeSpan.new()

var text = ""
