class_name SubtitleService
extends Reference


func s51_subtitles_to_string(subtitles: Array) -> String:
	var result = ""
	for subtitle in subtitles:
		if result.length() > 0:
			result += "\n\n"
		result += subtitle.to_string()
	return result


func convert_subtitles_to_csv_rows_and_columns(subtitles_by_key: Dictionary) -> Array:
	var keys = subtitles_by_key.keys().duplicate()
	keys.sort()
	var csv_rows_and_columns = []
	csv_rows_and_columns.append(["Key", "SourceString", "Comment"])
	for key in keys:
		var subtitles = subtitles_by_key[key]
		csv_rows_and_columns.append([key, s51_subtitles_to_string(subtitles)])
	return csv_rows_and_columns


func load_srt_file(path: String) -> SRTFile:
	var srt_file = SRTFile.new()
	srt_file.file_path = path
	var file = File.new()
	file.open(path, File.READ)
	srt_file.set_content(file.get_as_text())
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


func add_alternative_timecodes_to_subtitles(alt_timecodes_subtitles: Array, target_subtitles: Array, language_code: String):
	for i in range(min(alt_timecodes_subtitles.size(), target_subtitles.size())):
		target_subtitles[i].add_subtitle_as_alternative_timecode(alt_timecodes_subtitles[i], language_code)
