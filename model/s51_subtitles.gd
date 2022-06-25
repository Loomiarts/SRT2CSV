class_name S51Subtitles
extends Reference

var key = ""

var subtitles = []


func add_alternative_timecodes(alternative_timecodes_subtitles: S51Subtitles, language_code: String):
	if alternative_timecodes_subtitles != null:
		for i in range(min(subtitles.size(), alternative_timecodes_subtitles.subtitles.size())):
			subtitles[i].add_subtitle_as_alternative_timecode(alternative_timecodes_subtitles.subtitles[i], language_code)


func _to_string():
	var result = ""
	for subtitle in subtitles:
		if result.length() > 0:
			result += "\n\n"
		result += subtitle.to_string()
	return result
