extends WAT.Test

var service: SubtitleService


func pre():
	service = SubtitleService.new()


func test_should_convert_subtitles_to_string():
	# given:
	var subtitle1 = S51Subtitle.new()
	subtitle1.time.string_value = "00:00:00,000 --> 00:00:10,000"
	subtitle1.text = "Line 1."
	
	var subtitle2 = S51Subtitle.new()
	subtitle2.time.string_value = "00:00:20,000 --> 00:00:30,000"
	subtitle2.text = "Line 2."
	
	# when:
	var result = service.s51_subtitles_to_string([subtitle1, subtitle2])
	
	# then:
	asserts.is_equal(result, """00:00:00,000 --> 00:00:10,000
Line 1.

00:00:20,000 --> 00:00:30,000
Line 2.""")


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
	var subtitle1 = S51Subtitle.new()
	subtitle1.time.string_value = "00:00:00,000 --> 00:00:02,000"
	subtitle1.text = "Line 1."
	
	var subtitle2 = S51Subtitle.new()
	subtitle2.time.string_value = "00:00:02,000 --> 00:00:04,000"
	subtitle2.text = "Line 2."
	
	var subtitle3 = S51Subtitle.new()
	subtitle3.time.string_value = "00:00:00,000 --> 00:00:02,000"
	subtitle3.text = "Another line."
	
	# when:
	var result = service.convert_subtitles_to_csv_rows_and_columns({
		"sub_key_1": [subtitle1, subtitle2],
		"sub_key_2": [subtitle3],
	})
	
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


func test_should_add_alternative_timecodes_to_subtitles():
	# given:
	var subtitle1 = S51Subtitle.new()
	subtitle1.time.string_value = "00:00:00,000 --> 00:00:10,000"
	
	var subtitle2 = S51Subtitle.new()
	subtitle2.time.string_value = "00:00:20,000 --> 00:00:30,000"
	
	var alt_subtitle1 = S51Subtitle.new()
	alt_subtitle1.time.string_value = "00:00:01,000 --> 00:00:11,000"
	
	var alt_subtitle2 = S51Subtitle.new()
	alt_subtitle2.time.string_value = "00:00:21,000 --> 00:00:31,000"
	
	# when:
	service.add_alternative_timecodes_to_subtitles([alt_subtitle1, alt_subtitle2], [subtitle1, subtitle2], "pt-BR")
	
	# then:
	asserts.is_equal(subtitle1.time.string_value, "00:00:00,000 --> 00:00:10,000")
	asserts.is_equal(subtitle1.alternative_timecodes_by_language_code.size(), 1)
	asserts.is_equal(subtitle1.alternative_timecodes_by_language_code["pt-BR"].string_value, "00:00:01,000 --> 00:00:11,000")
	asserts.is_equal(subtitle2.time.string_value, "00:00:20,000 --> 00:00:30,000")
	asserts.is_equal(subtitle2.alternative_timecodes_by_language_code.size(), 1)
	asserts.is_equal(subtitle2.alternative_timecodes_by_language_code["pt-BR"].string_value, "00:00:21,000 --> 00:00:31,000")




