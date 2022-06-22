extends WAT.Test

var subtitle: S51Subtitle


func pre():
	subtitle = S51Subtitle.new()


func test_initialize_with_srt_subtitle():
	# given:
	var srt_subtitle = SRTSubtitle.new()
	srt_subtitle.time.start.string_value = "00:01:15,123"
	srt_subtitle.time.end.string_value = "00:02:15,123"
	srt_subtitle.text = "Example text."
	
	# when:
	subtitle.initialize_with_srt_subtitle(srt_subtitle)
	
	# then:
	asserts.is_equal(subtitle.time.start.string_value, "00:01:15,123")
	asserts.is_equal(subtitle.time.end.string_value, "00:02:15,123")
	asserts.is_equal(subtitle.text, "Example text.")


func test_add_srt_subtitle_as_alternative_timecode():
	# given:
	subtitle.time.start.string_value = "00:01:15,123"
	subtitle.time.end.string_value = "00:02:15,123"
	subtitle.text = "Example text."
	
	var srt_subtitle = SRTSubtitle.new()
	srt_subtitle.time.start.string_value = "00:01:16,123"
	srt_subtitle.time.end.string_value = "00:02:17,123"
	
	# when:
	subtitle.add_srt_subtitle_as_alternative_timecode(srt_subtitle, "pt-BR")
	
	# then:
	asserts.is_equal(subtitle.time.start.string_value, "00:01:15,123")
	asserts.is_equal(subtitle.time.end.string_value, "00:02:15,123")
	asserts.is_equal(subtitle.text, "Example text.")
	asserts.is_equal(subtitle.alternative_timecodes_by_language_code.size(), 1)
	asserts.is_equal(subtitle.alternative_timecodes_by_language_code["pt-BR"].start.string_value, "00:01:16,123")
	asserts.is_equal(subtitle.alternative_timecodes_by_language_code["pt-BR"].end.string_value, "00:02:17,123")


func test_to_string():
	# given:
	subtitle.time.start.string_value = "00:01:15,123"
	subtitle.time.end.string_value = "00:02:15,123"
	subtitle.text = "Example text."
	
	# then:
	asserts.is_equal(subtitle.to_string(), "00:01:15,123 --> 00:02:15,123\nExample text.\n\n")


func test_to_with_alternative_timecodes():
	# given:
	subtitle.time.start.string_value = "00:01:15,123"
	subtitle.time.end.string_value = "00:02:15,123"
	subtitle.alternative_timecodes_by_language_code["pt-BR"] = TimecodeSpan.new()
	subtitle.alternative_timecodes_by_language_code["pt-BR"].string_value = "00:02:15,123 --> 00:03:15,123"
	subtitle.text = "Example text."
	
	# then:
	asserts.is_equal(subtitle.to_string(), "00:01:15,123 --> 00:02:15,123\n(pt-BR) 00:02:15,123 --> 00:03:15,123\nExample text.\n\n")

