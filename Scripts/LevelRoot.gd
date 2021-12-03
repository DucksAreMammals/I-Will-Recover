extends Node2D

func _ready():
	load_level("Denial")

func load_level(level):
	var nested_level = load("res://Scenes/Screens/Levels/" + level + ".tscn").instance()
	$LevelCamera.level = nested_level
	$Player.level = nested_level
	add_child(nested_level)
