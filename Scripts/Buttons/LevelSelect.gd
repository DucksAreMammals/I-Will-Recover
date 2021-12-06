extends Button

export(int) var level_number
export(String, FILE) var scene
export(bool) var focus


func _ready():
	if focus:
		grab_focus()

	if level_number > Global.level:
		disabled = true


func _pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene)
