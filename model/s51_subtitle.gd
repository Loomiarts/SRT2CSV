# Model for a subtitle line using the Squad 51 internal format.
class_name S51Subtitle
extends Reference

class Timecode:
	var start = ""
	var end = ""


var timecode = Timecode.new()

var alternative_timecodes_by_language_code = {}

var text = ""


func initialize_with_srt_subtitle(srt_subtitle: SRTSubtitle):
	text = srt_subtitle.text
	timecode.start = srt_subtitle.timecode_start
	timecode.end = srt_subtitle.timecode_end
	alternative_timecodes_by_language_code = {}


func add_srt_subtitle_as_alternative_timecode(srt_subtitle: SRTSubtitle, language_code: String):
	var alternative_timecode = Timecode.new()
	alternative_timecode.start = srt_subtitle.timecode_start
	alternative_timecode.end = srt_subtitle.timecode_end
	alternative_timecodes_by_language_code[language_code] = alternative_timecode
