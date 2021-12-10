extends Node

var story

var level = 0

var music_volume = 100

var debug_mode = false

var use_silentwolf = false

var can_fullscreen = true

var pos_in_konami = 0
const KONAMI = [
	KEY_UP, KEY_UP, KEY_DOWN, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_LEFT, KEY_RIGHT, KEY_B, KEY_A
]

var start_time = INF
var end_time = -1
var time_valid = false


func _ready():
	set_pause_mode(Node.PAUSE_MODE_PROCESS)

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
	if Input.is_action_just_pressed("fullscreen") and can_fullscreen:
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
				time_valid = false
				pos_in_konami = 0

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


func start_timer():
	start_time = OS.get_ticks_msec()
	time_valid = true if not debug_mode else false


func end_timer():
	if time_valid:
		end_time = OS.get_ticks_msec()
	else:
		end_time = -1


func get_time():
	if time_valid:
		return (end_time - start_time) / 1000.0
	else:
		return -1.0
