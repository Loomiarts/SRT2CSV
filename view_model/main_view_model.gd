class_name MainViewModel
extends Reference

var alternative_timecode_language_code = "pt-BR"

var convert_initial_time_to_zero = true

var srt_files_paths = []

var alternative_timecode_srt_files_paths = []

var subtitle_service = SubtitleService.new()


func save_csv(file_path):
	subtitle_service.convert_srt_files_to_csv_file(srt_files_paths, file_path)
