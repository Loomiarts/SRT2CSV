extends WAT.Test

var csv_subtitles_file: CSVSubtitlesFile


func pre():
	csv_subtitles_file = CSVSubtitlesFile.new()


func test_should_convert_to_string():
	# given:
	var row1 = CSVSubtitlesRow.new()
	row1.key = "key1"
	row1.subtitles = "subtitles line1\nsubtitles line2"
	row1.comment = "comment with \"quotes\""
	
	var row2 = CSVSubtitlesRow.new()
	row2.key = "key2"
	row2.subtitles = "other subtitles."
	row2.comment = ""
	
	csv_subtitles_file.rows = [row1, row2]
	
	# when:
	var result = csv_subtitles_file.to_string()
	
	# then:
	asserts.is_equal(result, """\"Key\",\"SourceString\",\"Comment\"
\"key1\",\"subtitles line1\nsubtitles line2\",\"comment with \"\"quotes\"\"\"
\"key2\",\"other subtitles.\",\"\"""")


func test_should_update_with_new_and_existing_rows():
	# given:
	var row1 = CSVSubtitlesRow.new()
	row1.key = "key1"
	row1.subtitles = "00:00:00,000 --> 00:00:01,000\nsubtitles a"
	row1.comment = "comments a"
	
	var row2 = CSVSubtitlesRow.new()
	row2.key = "key2"
	row2.subtitles = "00:00:00,000 --> 00:00:01,000\nsubtitles b"
	row2.comment = "comments b"
	
	csv_subtitles_file.rows = [row1, row2]
	
	var s51_subtitles1 = S51Subtitles.new()
	s51_subtitles1.key = "key1"
	
	var s51_subtitle1_line1 = S51Subtitle.new()
	s51_subtitle1_line1.time.string_value = "00:00:00,000 --> 00:00:02,000"
	s51_subtitle1_line1.text = "updated subtitles line 1"
	
	var s51_subtitle1_line2 = S51Subtitle.new()
	s51_subtitle1_line2.time.string_value = "00:00:02,000 --> 00:00:04,000"
	s51_subtitle1_line2.text = "updated subtitles line 2"
	
	s51_subtitles1.subtitles = [s51_subtitle1_line1, s51_subtitle1_line2]
	
	var s51_subtitles2 = S51Subtitles.new()
	s51_subtitles2.key = "anewkey"
	
	var s51_subtitle2_line1 = S51Subtitle.new()
	s51_subtitle2_line1.time.string_value = "00:00:00,000 --> 00:00:03,000"
	s51_subtitle2_line1.text = "new subtitles"
	
	s51_subtitles2.subtitles = [s51_subtitle2_line1]
	
	# when:
	csv_subtitles_file.update([s51_subtitles1, s51_subtitles2])
	
	# then:
	asserts.is_equal(csv_subtitles_file.rows.size(), 3)
	asserts.is_equal(csv_subtitles_file.rows[0].key, "key1")
	asserts.is_equal(csv_subtitles_file.rows[0].subtitles, "00:00:00,000 --> 00:00:02,000\nupdated subtitles line 1\n\n00:00:02,000 --> 00:00:04,000\nupdated subtitles line 2")
	asserts.is_equal(csv_subtitles_file.rows[0].comment, "comments a")
	asserts.is_equal(csv_subtitles_file.rows[1].key, "key2")
	asserts.is_equal(csv_subtitles_file.rows[1].subtitles, "00:00:00,000 --> 00:00:01,000\nsubtitles b")
	asserts.is_equal(csv_subtitles_file.rows[1].comment, "comments b")
	asserts.is_equal(csv_subtitles_file.rows[2].key, "anewkey")
	asserts.is_equal(csv_subtitles_file.rows[2].subtitles, "00:00:00,000 --> 00:00:03,000\nnew subtitles")
	asserts.is_equal(csv_subtitles_file.rows[2].comment, "")
