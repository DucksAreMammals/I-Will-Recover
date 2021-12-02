extends Node2D

export var section_max := 4

var respawn_points
var section := 0
var section_offset := Vector2(400, 0)

func _ready():
	respawn_points = $RespawnPoints.get_children()

func get_respawn_point():
	return respawn_points[section].position

func next_section() -> bool:
	if section < section_max:
		section += 1
		return true

	return false
