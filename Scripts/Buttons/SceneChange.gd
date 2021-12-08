extends Button

export(String, FILE) var scene


func _pressed():
#warning-ignore:return_value_discarded
	get_tree().change_scene(scene)
