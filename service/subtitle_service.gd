class_name SubtitleService
extends Reference


func convert_subtitles_to_csv_rows_and_columns(subtitles: Array) -> Array:
	var csv_rows_and_columns = []
	csv_rows_and_columns.append(["Key", "SourceString", "Comment"])
	for s in subtitles:
		csv_rows_and_columns.append([s.key, s.to_string()])
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
