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


func add_srt_subtitle_as_alternative_timecode(srt_subtitle: SRTSubtitle, language_code: String):
	alternative_timecodes_by_language_code[language_code] = srt_subtitle.time.duplicate()