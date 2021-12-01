extends Button

export(String, FILE) var scene
export(bool) var focus


func _ready():
	if focus:
		grab_focus()


func _pressed():
	get_tree().change_scene(scene)
