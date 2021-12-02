extends Node

var story


func _ready():
	var file = File.new()

	if file.file_exists("res://story.json"):
		file.open("res://story.json", File.READ)
		var text = file.get_as_text()
		file.close()
		story = parse_json(text)
	else:
		print("story.json not found")
