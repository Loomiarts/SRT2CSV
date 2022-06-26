# Represents a CSV formatted subtitles file.
class_name CSVSubtitlesFile
extends Reference

# Array of CSVSubtitlesRow
var rows = []


# Updates the rows with the given array of S51Subtitles, updating the subtitles
# string of existing rows or creating new ones.
func update(subtitles: Array):
	for subtitle in subtitles:
		var existing_row = _search_row_by_key(subtitle.key)
		if existing_row == null:
			var new_row = CSVSubtitlesRow.new()
			new_row.key = subtitle.key
			new_row.subtitles = subtitle.to_string()
			rows.append(new_row)
		else:
			existing_row.subtitles = subtitle.to_string()


func _search_row_by_key(key: String):
	for row in rows:
		if row.key == key:
			return row
	return null


func _to_string():
	var result = _columns_to_string(["Key", "SourceString", "Comment"])
	for row in rows:
		if result.length() > 0:
			result += "\n"
		result += _columns_to_string([row.key, row.subtitles, row.comment])
	return result


func _columns_to_string(columns: Array) -> String:
	var column_str = ""
	for column in columns:
		if column_str.length() > 0:
			column_str += ","
		column_str += "\"%s\"" % column.replace("\"", "\"\"")
	return column_str
