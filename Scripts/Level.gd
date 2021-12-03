extends Node2D

export var section_max := 4
export(String, FILE) var next_level

var respawn_points
var section := 0
var section_offset := Vector2(400, 0)


func _ready():
	respawn_points = $RespawnPoints.get_children()

	$LevelCamera.connect("win", self, "_next_level")


func get_respawn_point():
	return respawn_points[section].position


func next_section() -> bool:
	if section < section_max:
		section += 1
		return true

	return false


func _next_level():
	get_tree().change_scene(next_level)
