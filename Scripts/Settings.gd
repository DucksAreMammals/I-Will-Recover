extends Control


func _ready():
	$MusicSlider.value = Global.music_volume


func _on_MusicSlider_value_changed(value):
	Global.music_volume = value
	Global.save_file()
	AudioController.update_volume()
