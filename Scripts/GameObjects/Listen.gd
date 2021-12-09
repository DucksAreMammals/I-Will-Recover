extends CanvasLayer

var story_key

var letter_interval = 0.025
var line_interval = 0.5

var running = false
var start_time = -1

onready var label = find_node("RichTextLabel")


func _ready():
	$Control.visible = false
	$Control.modulate = Color(1, 1, 1, 0)
# warning-ignore:return_value_discarded
	find_node("ExitButton").connect("pressed", self, "_exit")


func _process(_delta):
	var story_bit = Global.story[story_key]

	var text = ""

	var wait_time = 0.0
	var current_time = OS.get_ticks_msec() / 1000.0

	for line in story_bit:
		var current_line = ""

		for character in line["line"]:
			if current_time < start_time + wait_time:
				break

			current_line += character
			wait_time += letter_interval

		wait_time += line_interval

		match line["speaker"]:
			"internal":
				text += "[color=#aaaaaa]"
				text += current_line
				text += "[/color]"
			"self":
				text += "[color=#ffffff]"
				text += current_line
				text += "[/color]"
			"dad":
				text += "[color=#77ff77]"
				text += current_line
				text += "[/color]"

		text += "\n\n"

	label.bbcode_text = text


func show_story():
	PauseMenu.can_pause = false

	$Control.visible = true
	$Control/AnimationPlayer.play("Fade In")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	find_node("ExitButton").grab_focus()
	get_tree().paused = true

	start_time = OS.get_ticks_msec() / 1000.0
	running = true


func _exit():
	PauseMenu.can_pause = true

	$Control/AnimationPlayer.play_backwards("Fade In")
	yield($Control/AnimationPlayer, "animation_finished")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Control.visible = false
	get_tree().paused = false
