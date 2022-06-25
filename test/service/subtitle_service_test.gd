extends WAT.Test

var service: SubtitleService


func pre():
	service = SubtitleService.new()


func test_should_convert_to_csv():
	# given:
	var rows_and_columns = [
		["value", "other value", "yet other value"],
		["value with\nnew line", "value with \"quotes\""]
	]
	
	# when:
	var result = service.convert_rows_and_columns_to_csv(rows_and_columns)
	
	# then:
	asserts.is_equal(result, "\"value\",\"other value\",\"yet other value\"\n\"value with\nnew line\",\"value with \"\"quotes\"\"\"")


func test_should_convert_subtitles_to_csv_rows_and_columns():
	# given:
	var line1 = S51Subtitle.new()
	line1.time.string_value = "00:00:00,000 --> 00:00:02,000"
	line1.text = "Line 1."
	
	var line2 = S51Subtitle.new()
	line2.time.string_value = "00:00:02,000 --> 00:00:04,000"
	line2.text = "Line 2."
	
	var line3 = S51Subtitle.new()
	line3.time.string_value = "00:00:00,000 --> 00:00:02,000"
	line3.text = "Another line."
	
	var subtitles1 = S51Subtitles.new()
	subtitles1.key = "sub_key_1"
	subtitles1.subtitles = [line1, line2]
	
	var subtitles2 = S51Subtitles.new()
	subtitles2.key = "sub_key_2"
	subtitles2.subtitles = [line3]
	
	# when:
	var result = service.convert_subtitles_to_csv_rows_and_columns([subtitles1, subtitles2])
	
	# then:
	var subtitles_internal_format1 = """00:00:00,000 --> 00:00:02,000
Line 1.

00:00:02,000 --> 00:00:04,000
Line 2."""
	
	var subtitles_internal_format2 = """00:00:00,000 --> 00:00:02,000
Another line."""

	asserts.is_equal(result, [
		["Key", "SourceString", "Comment"],
		["sub_key_1", subtitles_internal_format1],
		["sub_key_2", subtitles_internal_format2],
	])


