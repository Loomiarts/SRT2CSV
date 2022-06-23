class_name MainViewModel
extends Reference

var alternative_timecode_language_code = "pt-BR"

var convert_initial_time_to_zero = true

var srt_files_paths = []

var alternative_timecode_srt_files_paths = []

var subtitle_service = SubtitleService.new()


func save_csv(csv_file_path):
	var srt_files = _batch_load_srt(srt_files_paths)
	var alternative_language_timecode_srt_files = _batch_load_srt(alternative_timecode_srt_files_paths)
	var s51_subtitles = _convert_srt_files_to_s51_subtitles(srt_files)
	var s51_alternative_lang_timecodes_subtitles = _convert_srt_files_to_s51_subtitles(alternative_language_timecode_srt_files)
	subtitle_service.add_alternative_timecodes_to_subtitles(s51_alternative_lang_timecodes_subtitles, s51_subtitles, alternative_timecode_language_code)
	var csv_rows_and_columns = subtitle_service.convert_subtitles_to_csv_rows_and_columns(s51_subtitles)
	subtitle_service.save_csv(csv_rows_and_columns, csv_file_path)


func _batch_load_srt(paths) -> Array:
	var result = []
	for path in paths:
		var srt_file = subtitle_service.load_srt_file(path)
		if convert_initial_time_to_zero:
			srt_file.offset_to_start_time_zero()
		result.append(srt_file)
	return result


func _convert_srt_files_to_s51_subtitles(srt_files: Array) -> Dictionary:
	var result = {}
	for srt_file in srt_files:
		result[srt_file.get_name_without_extension()] = srt_file.convert_to_internal_format_subtitles()
	return result
