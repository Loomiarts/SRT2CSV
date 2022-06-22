extends WAT.Test

var timecode_span: TimecodeSpan


func pre():
	timecode_span = TimecodeSpan.new()


func test_should_init_with_zero():
	asserts.is_equal(timecode_span.start.string_value, "00:00:00,000")
	asserts.is_equal(timecode_span.end.string_value, "00:00:00,000")


func test_should_set_string_value():
	# when:
	timecode_span.string_value = "01:20:33,123 --> 02:30:00,456"
	
	# then:
	asserts.is_equal(timecode_span.start.string_value, "01:20:33,123")
	asserts.is_equal(timecode_span.end.string_value, "02:30:00,456")


func test_should_get_string_value():
	# given:
	timecode_span.start.string_value = "01:20:33,123"
	timecode_span.end.string_value = "02:30:00,456"
	
	# then:
	asserts.is_equal(timecode_span.string_value, "01:20:33,123 --> 02:30:00,456")
	asserts.is_equal(timecode_span.to_string(), "01:20:33,123 --> 02:30:00,456")


func test_should_duplicate():
	# given:
	timecode_span.start.string_value = "01:20:33,123"
	timecode_span.end.string_value = "02:30:00,456"
	
	# when:
	var duplicated_timecode_span = timecode_span.duplicate()
	
	timecode_span.start.string_value = "11:20:33,123"
	timecode_span.end.string_value = "12:30:00,456"
	
	# then:
	asserts.is_equal(duplicated_timecode_span.start.string_value, "01:20:33,123")
	asserts.is_equal(duplicated_timecode_span.end.string_value, "02:30:00,456")


func test_should_offset():
	# given:
	timecode_span.start.seconds = 61.5
	timecode_span.end.seconds = 63.0
	
	# when:
	timecode_span.offset(1.2)
	
	# then:
	asserts.is_equal(timecode_span.string_value, "00:01:02,700 --> 00:01:04,200")


func test_should_offset_negative_value():
	# given:
	timecode_span.start.seconds = 61.5
	timecode_span.end.seconds = 63.0
	
	# when:
	timecode_span.offset(-1.3)
	
	# then:
	asserts.is_equal(timecode_span.string_value, "00:01:00,200 --> 00:01:01,700")
