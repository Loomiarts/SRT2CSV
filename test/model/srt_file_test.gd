extends WAT.Test

var srt_file: SRTFile


func pre():
	srt_file = SRTFile.new()


func test_should_return_name_without_extension():
	# given:
	srt_file.file_path = "D://Projects/Folder/TheSubtitles.srt"
	
	# then:
	asserts.is_equal(srt_file.get_name_without_extension(), "TheSubtitles")


func test_should_return_subtitles_array():
	# given:
	srt_file.content = """
1
00:00:00,000 --> 00:00:10,000
Line 1,
line 2.

2
00:00:20,000 --> 00:00:30,000
Line 3,
line 4,
line 5."""
	
	# when:
	var subtitles = srt_file.get_subtitles()
	
	# then:
	asserts.is_equal(subtitles.size(), 2)
	asserts.is_equal(subtitles[0].time.to_string(), "00:00:00,000 --> 00:00:10,000")
	asserts.is_equal(subtitles[0].text, "Line 1,\nline 2.")
	asserts.is_equal(subtitles[1].time.to_string(), "00:00:20,000 --> 00:00:30,000")
	asserts.is_equal(subtitles[1].text, "Line 3,\nline 4,\nline 5.")
