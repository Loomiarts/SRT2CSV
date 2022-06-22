extends WAT.Test

var timecode: Timecode


func pre():
	timecode = Timecode.new()


func test_should_init_with_zero():
	asserts.is_equal(timecode.string_value, "00:00:00,000")


func test_should_implement_to_string_func():
	# given:
	timecode.string_value = "01:10:10,123"
	
	# then:
	asserts.is_equal(timecode.to_string(), "01:10:10,123")


func test_should_set_seconds():
	# when:
	timecode.seconds = 100.123
	
	# then:
	asserts.is_equal(timecode.string_value, "00:01:40,123")


func test_should_set_seconds_without_frac():
	# when:
	timecode.seconds = 100.0
	
	# then:
	asserts.is_equal(timecode.string_value, "00:01:40,000")
