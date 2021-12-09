extends Node

var story

var level = 0

var music_volume = 100

var debug_mode = false

var pos_in_konami = 0
const KONAMI = [
	KEY_UP, KEY_UP, KEY_DOWN, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_LEFT, KEY_RIGHT, KEY_B, KEY_A
]


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

	if Input.is_action_just_pressed("debug_reset_save") and debug_mode:
		level = 0
		save_file()

	if Input.is_action_just_pressed("debug_unlock_all") and debug_mode:
		level = 5
		save_file()


func _input(e):
	if e is InputEventKey and e.pressed:
		if e.scancode == KONAMI[pos_in_konami]:
			pos_in_konami += 1
			if pos_in_konami == len(KONAMI):
				debug_mode = not debug_mode
				pos_in_konami = 0

				if debug_mode:
					print("debug mode enabled")
				else:
					print("debug mode disabled")

		elif e.scancode == KONAMI[0]:
			pos_in_konami = 1
		else:
			pos_in_konami = 0


func save_file():
	var file = File.new()

	file.open("user://save", File.WRITE)
	file.store_var(level)
	file.store_var(music_volume)
	file.close()


func _load_file():
	var file = File.new()

	if file.file_exists("user://save"):
		file.open("user://save", File.READ)
		level = file.get_var()
		music_volume = file.get_var()
		file.close()
	else:
		save_file()
