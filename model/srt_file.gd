# Wrapper for a SRT file (metadata and content related to it).
class_name SRTFile
extends Reference

var file_path = ""

var subtitles = []


func set_content(text_content: String):
	var regex = RegEx.new()
	regex.compile("\\d+\\n(\\d\\d:\\d\\d:\\d\\d,\\d\\d\\d --> \\d\\d:\\d\\d:\\d\\d,\\d\\d\\d)\\n((?:.*(?:\\n[^\\n])?)*)")
	var regex_matches = regex.search_all(text_content)
	subtitles = []
	for regex_match in regex_matches:
		var subtitle = SRTSubtitle.new()
		subtitle.time.string_value = regex_match.strings[1]
		subtitle.text = regex_match.strings[2]
		subtitles.append(subtitle)


func get_name_without_extension() -> String:
	var basename = file_path.get_basename()
	var dir = file_path.get_base_dir()
	return basename.substr(dir.length() + 1)


func convert_to_s51_subtitles() -> S51Subtitles:
	var result = S51Subtitles.new()
	result.key = get_name_without_extension()
	for srt_subtitle in subtitles:
		var s51_subtitle = S51Subtitle.new()
		s51_subtitle.initialize_with_srt_subtitle(srt_subtitle)
		result.subtitles.append(s51_subtitle)
	return result


func offset_to_start_time_zero():
	if subtitles.size() > 0:
		var offset_time = -subtitles[0].time.start.seconds
		for subtitle in subtitles:
			subtitle.time.offset(offset_time)

