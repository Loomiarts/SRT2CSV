extends WAT.Test

var srt_file: SRTFile


func pre():
	srt_file = SRTFile.new()


func test_should_return_name_without_extension():
	# given:
	srt_file.file_path = "D://Projects/Folder/TheSubtitles.srt"
	
	# then:
	asserts.is_equal(srt_file.get_name_without_extension(), "TheSubtitles")


func test_should_set_content_as_string():
	# given:
	srt_file.set_content("""
1
00:00:00,000 --> 00:00:10,000
Line 1,
line 2.

2
00:00:20,000 --> 00:00:30,000
Line 3,
line 4,
line 5.""")
	
	# when:
	var subtitles = srt_file.subtitles
	
	# then:
	asserts.is_equal(subtitles.size(), 2)
	asserts.is_equal(subtitles[0].time.to_string(), "00:00:00,000 --> 00:00:10,000")
	asserts.is_equal(subtitles[0].text, "Line 1,\nline 2.")
	asserts.is_equal(subtitles[1].time.to_string(), "00:00:20,000 --> 00:00:30,000")
	asserts.is_equal(subtitles[1].text, "Line 3,\nline 4,\nline 5.")


func test_should_convert_to_internal_format():
	# given:
	srt_file.set_content("""
1
00:00:00,000 --> 00:00:10,000
Line 1.

2
00:00:20,000 --> 00:00:30,000
Line 2.""")
	
	# when:
	var result = srt_file.convert_to_internal_format_subtitles()
	
	# then:
	asserts.is_equal(result, """00:00:00,000 --> 00:00:10,000
Line 1.

00:00:20,000 --> 00:00:30,000
Line 2.""")


func test_should_offset_to_zero():
	# given:
	srt_file.set_content("""
1
00:00:02,000 --> 00:00:10,000
Line 1.

2
00:00:20,000 --> 00:00:30,000
Line 2.""")
	
	# when:
	srt_file.offset_to_start_time_zero()
	
	# then:
	asserts.is_equal(srt_file.subtitles[0].time.to_string(), "00:00:00,000 --> 00:00:08,000")
	asserts.is_equal(srt_file.subtitles[1].time.to_string(), "00:00:18,000 --> 00:00:28,000")

