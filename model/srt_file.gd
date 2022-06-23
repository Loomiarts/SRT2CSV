# Wrapper for a SRT file (metadata and content related to it).
class_name SRTFile
extends Reference

var file_path = ""

var content = ""


func get_name_without_extension() -> String:
	var basename = file_path.get_basename()
	var dir = file_path.get_base_dir()
	return basename.substr(dir.length() + 1)


func get_subtitles() -> Array:
	var regex = RegEx.new()
	regex.compile("\\d+\\n(\\d\\d:\\d\\d:\\d\\d,\\d\\d\\d --> \\d\\d:\\d\\d:\\d\\d,\\d\\d\\d)\\n((?:.*(?:\\n[^\\n])?)*)")
	var regex_matches = regex.search_all(content)
	var subtitles = []
	for regex_match in regex_matches:
		var subtitle = SRTSubtitle.new()
		subtitle.time.string_value = regex_match.strings[1]
		subtitle.text = regex_match.strings[2]
		subtitles.append(subtitle)
	return subtitles


func convert_to_internal_format_subtitles() -> String:
	var result = ""
	var srt_subtitles = get_subtitles()
	for srt_subtitle in srt_subtitles:
		if result.length() > 0:
			result += "\n\n"
		var s51_subtitle = S51Subtitle.new()
		s51_subtitle.initialize_with_srt_subtitle(srt_subtitle)
		result += s51_subtitle.to_string()
	return result
