extends Control


var view_model: MainViewModel


func _ready():
	view_model = MainViewModel.new()
	_refresh_ui()


func _refresh_ui():
	$PanelContainer/VBox/XFilesSelectedLabel.text = "%d .srt files selected." % view_model.srt_files_paths.size()
	$PanelContainer/VBox/ConvertInitialTimeToZeroCheckBox.pressed = view_model.convert_initial_time_to_zero
	$PanelContainer/VBox/HBox/LanguageCodeEdit.text = view_model.alternative_timecode_language_code
	$PanelContainer/VBox/XAlternativeTimecodesFilesSelectedLabel.text = "%d .srt files selected for alternative timecodes." % view_model.alternative_timecode_srt_files_paths.size()


func _on_ConvertInitialTimeToZeroCheckBox_toggled(button_pressed):
	view_model.convert_initial_time_to_zero = button_pressed


func _on_SelectSRTButton_pressed():
	$OpenSrcFilesDialog.popup()


func _on_SaveButton_pressed():
	$SaveFileDialog.popup()


func _on_OpenSrcFilesDialog_files_selected(paths):
	view_model.srt_files_paths = Array(paths)
	_refresh_ui()


func _on_SaveFileDialog_file_selected(path):
	view_model.save_csv(path)
	$PanelContainer/VBox/ResultLabel.visible = true


func _on_LanguageCodeEdit_text_changed(new_text):
	view_model.alternative_timecode_language_code = new_text


func _on_SelectAlternativeTimecodesSRTButton_pressed():
	$OpenAlternativeLangSrtFilesDialog.popup()


func _on_OpenAlternativeLangSrtFilesDialog_files_selected(paths):
	view_model.alternative_timecode_srt_files_paths = paths
