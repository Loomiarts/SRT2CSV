class_name MainViewModel
extends Reference

var alternative_timecode_language_code = "pt-BR"

var convert_initial_time_to_zero = true

var srt_files_paths = []

var alternative_timecode_srt_files_paths = []

var subtitle_service = SubtitleService.new()


func save_csv(csv_file_path):
	var srt_files = []
	for srt_file_path in srt_files_paths:
		var srt_file = subtitle_service.load_srt_file(srt_file_path)
		if convert_initial_time_to_zero:
			srt_file.offset_to_start_time_zero()
		srt_files.append(srt_file)
	var csv_rows_and_columns = subtitle_service.convert_srt_files_to_csv_rows_and_columns(srt_files)
	subtitle_service.save_csv(csv_rows_and_columns, csv_file_path)
