extends WAT.Test

var subtitles: S51Subtitles


func pre():
	subtitles = S51Subtitles.new()


func test_should_convert_subtitles_to_string():
	# given:
	var subtitle1 = S51Subtitle.new()
	subtitle1.time.string_value = "00:00:00,000 --> 00:00:10,000"
	subtitle1.text = "Line 1."
	
	var subtitle2 = S51Subtitle.new()
	subtitle2.time.string_value = "00:00:20,000 --> 00:00:30,000"
	subtitle2.text = "Line 2."
	
	subtitles.subtitles = [subtitle1, subtitle2]
	
	# when:
	var result = subtitles.to_string()
	
	# then:
	asserts.is_equal(result, """00:00:00,000 --> 00:00:10,000
Line 1.

00:00:20,000 --> 00:00:30,000
Line 2.""")


func test_should_add_alternative_timecodes_to_subtitles():
	# given:
	var line1 = S51Subtitle.new()
	line1.time.string_value = "00:00:00,000 --> 00:00:10,000"
	var line2 = S51Subtitle.new()
	line2.time.string_value = "00:00:20,000 --> 00:00:30,000"
	var subtitles1 = S51Subtitles.new()
	subtitles1.subtitles = [line1, line2]
	
	var line3 = S51Subtitle.new()
	line3.time.string_value = "00:00:01,000 --> 00:00:11,000"
	var line4 = S51Subtitle.new()
	line4.time.string_value = "00:00:21,000 --> 00:00:31,000"
	var subtitles2 = S51Subtitles.new()
	subtitles2.subtitles = [line3, line4]
	
	# when:
	subtitles1.add_alternative_timecodes(subtitles2, "pt-BR")
	
	# then:
	asserts.is_equal(subtitles1.subtitles[0].time.string_value, "00:00:00,000 --> 00:00:10,000")
	asserts.is_equal(subtitles1.subtitles[0].alternative_timecodes_by_language_code.size(), 1)
	asserts.is_equal(subtitles1.subtitles[0].alternative_timecodes_by_language_code["pt-BR"].string_value, "00:00:01,000 --> 00:00:11,000")
	asserts.is_equal(subtitles1.subtitles[1].time.string_value, "00:00:20,000 --> 00:00:30,000")
	asserts.is_equal(subtitles1.subtitles[1].alternative_timecodes_by_language_code.size(), 1)
	asserts.is_equal(subtitles1.subtitles[1].alternative_timecodes_by_language_code["pt-BR"].string_value, "00:00:21,000 --> 00:00:31,000")

