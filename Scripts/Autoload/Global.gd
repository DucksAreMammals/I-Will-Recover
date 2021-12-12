extends Node

var story
var level := 0
var music_volume := 100
var speedrun_mode := false

var debug_mode := false
var can_fullscreen := true

var use_silentwolf := false

var start_time := 0.0
var end_time := -1.0
var time_valid := false

var deaths := 0

var pos_in_konami := 0
const KONAMI = [
	KEY_UP, KEY_UP, KEY_DOWN, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_LEFT, KEY_RIGHT, KEY_B, KEY_A
]


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
	file.store_var(speedrun_mode)
	file.close()


func _load_file():
	var file = File.new()

	if file.file_exists("user://save"):
		file.open("user://save", File.READ)
		level = file.get_var()
		music_volume = file.get_var()
		speedrun_mode = file.get_var()
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


func get_time(use_end = true):
	if time_valid:
		if use_end:
			return (end_time - start_time) / 1000.0
		else:
			return (OS.get_ticks_msec() - start_time) / 1000.0
	else:
		return -1.0


func to_time(seconds, cutoff = true):
	var minutes = floor(seconds / 60)
	seconds = seconds - (minutes * 60)

	if cutoff:
		return str(minutes) + "m " + str(floor(seconds)) + "s"
	else:
		return str(minutes) + "m " + str(seconds) + "s"
