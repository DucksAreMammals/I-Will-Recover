extends Button

export(int) var level_number
export(String, FILE) var scene
export(bool) var focus


func _ready():
	if focus:
		grab_focus()


func _process(_delta):
	if level_number > Global.level:
		disabled = true
	else:
		disabled = false


func _pressed():
	FadeScreen.fade_in()
	yield(FadeScreen, "AnimationFinished")
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene)
