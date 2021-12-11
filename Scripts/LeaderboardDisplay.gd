extends Control


func _ready():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	FadeScreen.fade_out_fast()
	FadeScreen.set_text("")
	$Leaderboard.reload_leaderboard()
