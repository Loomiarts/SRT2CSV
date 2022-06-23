class_name SubtitleService
extends Reference


func convert_srt_files_to_csv_file(srt_files_paths: Array, csv_file_path: String):
	var keys = []
	var subtitles_by_key = {}
	for srt_file_path in srt_files_paths:
		var srt_file = load_srt_file(srt_file_path)
		var key = srt_file.get_name_without_extension()
		keys.append(key)
		subtitles_by_key[key] = srt_file.convert_to_internal_format_subtitles()
	keys.sort()
	var csv_rows_and_columns = []
	csv_rows_and_columns.append(["Key", "SourceString", "Comment"])
	for key in keys:
		csv_rows_and_columns.append([key, subtitles_by_key[key]])
	save_csv(csv_rows_and_columns, csv_file_path)


func convert_srt_files_to_csv_rows_and_columns(srt_files: Array) -> Array:
	var keys = []
	var subtitles_by_key = {}
	for srt_file in srt_files:
		var key = srt_file.get_name_without_extension()
		keys.append(key)
		subtitles_by_key[key] = srt_file.convert_to_internal_format_subtitles()
	keys.sort()
	var csv_rows_and_columns = []
	csv_rows_and_columns.append(["Key", "SourceString", "Comment"])
	for key in keys:
		csv_rows_and_columns.append([key, subtitles_by_key[key]])
	return csv_rows_and_columns


func load_srt_file(path: String) -> SRTFile:
	var srt_file = SRTFile.new()
	srt_file.file_path = path
	var file = File.new()
	file.open(path, File.READ)
	srt_file.content = file.get_as_text()
	return srt_file


func save_csv(rows_and_columns: Array, file_path: String):
	var file_content = convert_rows_and_columns_to_csv(rows_and_columns)
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_string(file_content)
	file.close()


func convert_rows_and_columns_to_csv(rows_and_columns: Array) -> String:
	var csv = ""
	for row in rows_and_columns:
		if csv.length() > 0:
			csv += "\n"
		var column_str = ""
		for column in row:
			if column_str.length() > 0:
				column_str += ","
			column_str += "\"%s\"" % column.replace("\"", "\"\"")
		csv += column_str
	return csv
