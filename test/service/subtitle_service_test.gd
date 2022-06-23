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


func test_should_convert_srt_files_to_csv_rows_and_columns():
	# given:
	var srt1 = SRTFile.new()
	srt1.file_path = "srts/sub1.srt"
	srt1.set_content("""1
00:00:00,000 --> 00:00:02,000
Line 1.

2
00:00:02,000 --> 00:00:04,000
Line 2.""")
	
	var srt2 = SRTFile.new()
	srt2.file_path = "srts/sub2.srt"
	srt2.set_content("""1
00:00:00,000 --> 00:00:02,000
Another line.""")
	
	# when:
	var result = service.convert_srt_files_to_csv_rows_and_columns([srt1, srt2])
	
	# then:
	var subtitles_internal_format1 = """00:00:00,000 --> 00:00:02,000
Line 1.

00:00:02,000 --> 00:00:04,000
Line 2."""
	
	var subtitles_internal_format2 = """00:00:00,000 --> 00:00:02,000
Another line."""
	print(result)
	print([
		["Key", "SourceString", "Comment"],
		["sub1", subtitles_internal_format1],
		["sub2", subtitles_internal_format2],
	])
	asserts.is_equal(result, [
		["Key", "SourceString", "Comment"],
		["sub1", subtitles_internal_format1],
		["sub2", subtitles_internal_format2],
	])
