extends Node2D

export var level_number := 0
export var level_name := ""
export var section_max := 4
export(String, FILE) var next_level

var respawn_points
var section := 0
var section_offset := Vector2(400, 0)


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	respawn_points = $RespawnPoints.get_children()
#warning-ignore:return_value_discarded
	$LevelCamera.connect("win", self, "_next_level")
	Global.level = level_number
	Global.save_file()

	get_tree().paused = true
	$Fade.set_text(level_name)
	$Fade.fade_out()
	yield($Fade, "AnimationFinished")
	get_tree().paused = false


func get_respawn_point(ask = -1):
	if ask == -1:
		ask = section

	return respawn_points[ask].position


func next_section() -> bool:
	if section < section_max:
		section += 1
		return true

	return false


func _next_level():
	get_tree().paused = true
	$Fade.set_text("")
	$Fade.fade_in()
	yield($Fade, "AnimationFinished")

#warning-ignore:return_value_discarded
	get_tree().change_scene(next_level)
