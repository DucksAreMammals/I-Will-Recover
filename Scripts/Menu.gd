extends Control


func _ready():
	$Fade/ColorRect.modulate = Color(1, 1, 1, 0)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
