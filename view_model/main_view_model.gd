class_name MainViewModel
extends Reference

var alternative_timecode_language_code = "pt-BR"

var convert_initial_time_to_zero = true

var srt_files_paths_as_text = ""

var srt_files_paths_as_array: Array setget _set_srt_files_paths_as_array, _get_srt_files_paths_as_array

var alternative_timecode_srt_files_paths = []

var subtitle_service = SubtitleService.new()


func save_csv(csv_file_path):
	var csv_file = subtitle_service.load_csv(csv_file_path)
	var srt_files = _batch_load_srt(self.srt_files_paths_as_array)
	var alternative_language_timecode_srt_files = _batch_load_srt(alternative_timecode_srt_files_paths)
	var s51_subtitles = _convert_srt_files_to_s51_subtitles(srt_files)
	var s51_alternative_lang_timecodes_subtitles = _convert_srt_files_to_s51_subtitles(alternative_language_timecode_srt_files)
	for subtitle in s51_subtitles:
		var alternative_timecode_subtitles = _find_by_key(s51_alternative_lang_timecodes_subtitles, subtitle.key)
		subtitle.add_alternative_timecodes(alternative_timecode_subtitles, alternative_timecode_language_code)
	csv_file.update(s51_subtitles)
	subtitle_service.save_csv(csv_file, csv_file_path)


func _find_by_key(subtitles: Array, key: String) -> S51Subtitles:
	for subtitle in subtitles:
		if subtitle.key == key:
			return subtitle
	return null


func _batch_load_srt(paths) -> Array:
	var result = []
	for path in paths:
		var srt_file = subtitle_service.load_srt_file(path)
		if convert_initial_time_to_zero:
			srt_file.offset_to_start_time_zero()
		result.append(srt_file)
	return result


func _convert_srt_files_to_s51_subtitles(srt_files: Array) -> Array:
	var result = []
	for srt_file in srt_files:
		result.append(srt_file.convert_to_s51_subtitles())
	return result


func _set_srt_files_paths_as_array(array: Array):
	srt_files_paths_as_text = ""
	for path in array:
		if srt_files_paths_as_text.length() > 0:
			srt_files_paths_as_text += "\n"
		srt_files_paths_as_text += path


func _get_srt_files_paths_as_array() -> Array:
	return srt_files_paths_as_text.split("\n", false)
