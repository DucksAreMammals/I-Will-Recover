extends CanvasLayer

var story_key
var story_bit

var letter_interval = 0.05
var line_interval = 1.0

onready var label = find_node("RichTextLabel")


func _ready():
	$Control.visible = false
# warning-ignore:return_value_discarded
	find_node("ExitButton").connect("pressed", self, "_exit")


func show_story():
	find_node("ExitButton").grab_focus()
	get_tree().paused = true

	$Control.visible = true

	story_bit = Global.story[story_key]

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
	$Control.visible = false
	get_tree().paused = false
