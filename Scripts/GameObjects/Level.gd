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

	if Global.level < level_number:
		Global.level = level_number
		Global.save_file()

	get_tree().paused = true
	PauseMenu.can_pause = false
	FadeScreen.set_text(level_name)
	FadeScreen.fade_out()
	yield(FadeScreen, "AnimationFinished")
	get_tree().paused = false
	PauseMenu.can_pause = true


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
	PauseMenu.can_pause = false
	FadeScreen.set_text("")
	FadeScreen.fade_in()
	yield(FadeScreen, "AnimationFinished")

#warning-ignore:return_value_discarded
	get_tree().change_scene(next_level)
