extends Node

var story

var level = 0

var music_level = 80


func _ready():
	var file = File.new()

	if file.file_exists("res://story.json"):
		file.open("res://story.json", File.READ)
		var text = file.get_as_text()
		file.close()
		story = parse_json(text)
	else:
		print("story.json not found")

	_load_file()


func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

	if Input.is_action_just_pressed("debug_reset_save"):
		level = 0
		save_file()


func save_file():
	var file = File.new()

	file.open("user://save", File.WRITE)
	file.store_var(level)
	file.close()


func _load_file():
	var file = File.new()

	if file.file_exists("user://save"):
		file.open("user://save", File.READ)
		level = file.get_var()
		file.close()
	else:
		save_file()
