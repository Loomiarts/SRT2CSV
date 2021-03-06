# Model for a subtitle line using the Squad 51 internal format.
class_name S51Subtitle
extends Reference

var time: TimecodeSpan = TimecodeSpan.new()

var alternative_timecodes_by_language_code = {}

var text = ""


func initialize_with_srt_subtitle(srt_subtitle: SRTSubtitle):
	text = srt_subtitle.text
	time = srt_subtitle.time.duplicate()
	alternative_timecodes_by_language_code = {}


func add_subtitle_as_alternative_timecode(subtitle, language_code: String):
	if subtitle.time.to_string() != self.time.to_string():
		alternative_timecodes_by_language_code[language_code] = subtitle.time.duplicate()


func _to_string():
	var result = "%s\n" % time.to_string()
	for language_code in alternative_timecodes_by_language_code:
		result += "(%s) %s\n" % [language_code, alternative_timecodes_by_language_code[language_code].to_string()]
	result += text
	return result
