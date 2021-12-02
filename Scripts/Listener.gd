extends Area2D

export var story_key := ""


func _ready():
	connect("body_entered", self, "_listen")
	$Listen.story_key = story_key


func _listen(body):
	if body.is_in_group("player"):
		$Listen.show_story()
