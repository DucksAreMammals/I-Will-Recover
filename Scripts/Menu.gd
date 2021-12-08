extends Control


func _ready():
	FadeScreen.fade_out_fast()
	FadeScreen.set_text("")
	PauseMenu.can_pause = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
