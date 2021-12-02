extends Node

var story


func _ready():
	var file = File.new()
	file.open("story.json", File.READ)
	var text = file.get_as_text()
	file.close()
	story = parse_json(text)
