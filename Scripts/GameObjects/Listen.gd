extends CanvasLayer

var story_key

var letter_interval = 0.05
var line_interval = 1.0

onready var label = find_node("RichTextLabel")


func _ready():
	$Control.visible = false
	$Control.modulate = Color(1, 1, 1, 0)
# warning-ignore:return_value_discarded
	find_node("ExitButton").connect("pressed", self, "_exit")


func show_story():
	$Control.visible = true
	$Control/AnimationPlayer.play("Fade In")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	find_node("ExitButton").grab_focus()
	get_tree().paused = true

	$Control.visible = true

	var story_bit = Global.story[story_key]

	var text = ""

	for line in story_bit:
		match line["speaker"]:
			"internal":
				text += "[color=#aaaaaa]"
				text += line["line"]
				text += "[/color]"
			"self":
				text += "[color=#ff99ff]"
				text += line["line"]
				text += "[/color]"
			"dad":
				text += "[color=#77ff77]"
				text += line["line"]
				text += "[/color]"

		text += "\n\n"

	label.bbcode_text = text


func _exit():
	$Control/AnimationPlayer.play_backwards("Fade In")
	yield($Control/AnimationPlayer, "animation_finished")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Control.visible = false
	get_tree().paused = false
