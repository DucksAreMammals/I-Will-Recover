extends Node2D

export var section_max := 4
export(String, FILE) var next_level

var respawn_points
var section := 0
var section_offset := Vector2(400, 0)


func _ready():
	respawn_points = $RespawnPoints.get_children()

#warning-ignore:return_value_discarded
	$LevelCamera.connect("win", self, "_next_level")


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
#warning-ignore:return_value_discarded
	get_tree().change_scene(next_level)
