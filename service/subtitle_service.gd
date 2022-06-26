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


func load_csv(file_path: String) -> CSVSubtitlesFile:
	var result = CSVSubtitlesFile.new()
	var file = File.new()
	var open_status = file.open(file_path, File.READ)
	if open_status == OK:
		var line = Array(file.get_csv_line())
		while line.size() > 0 and line != [""]:
			result.add_row(line)
			line = Array(file.get_csv_line())
	file.close()
	return result


func save_csv(csv: CSVSubtitlesFile, file_path: String):
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_string(csv.to_string())
	file.close()
