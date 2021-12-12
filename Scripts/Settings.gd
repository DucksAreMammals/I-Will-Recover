extends Control


func _ready():
	$MusicSlider.value = Global.music_volume
	$MusicSlider.grab_focus()
	$SpeedrunBox.pressed = Global.speedrun_mode
	FadeScreen.fade_out_fast()


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		$MenuButton._pressed()


func _on_MusicSlider_value_changed(value):
	Global.music_volume = value
	Global.save_file()
	AudioController.update_volume()


func _on_SpeedrunBox_toggled(button_pressed):
	Global.speedrun_mode = button_pressed
	Global.save_file()
