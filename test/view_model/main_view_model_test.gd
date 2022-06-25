extends WAT.Test

var view_model: MainViewModel


func pre():
	view_model = MainViewModel.new()


func test_should_set_paths_as_string():
	# when:
	view_model.srt_files_paths_as_text = "path1\npath2\n\npath3"
	
	# then:
	asserts.is_equal(view_model.srt_files_paths_as_text, "path1\npath2\n\npath3")
	asserts.is_equal(view_model.srt_files_paths_as_array, ["path1", "path2", "path3"])


func test_should_set_paths_as_array():
	# when:
	view_model.srt_files_paths_as_array = ["path1", "path2", "path3"]
	
	# then:
	asserts.is_equal(view_model.srt_files_paths_as_text, "path1\npath2\npath3")
	asserts.is_equal(view_model.srt_files_paths_as_array, ["path1", "path2", "path3"])
