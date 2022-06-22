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
		subtitle.time = regex_match.strings[1]
		subtitle.text = regex_match.strings[2]
		subtitles.append(subtitle)
	return subtitles
