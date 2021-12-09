extends Button

export(String, FILE) var scene


func _pressed():
	FadeScreen.fade_in()
	FadeScreen.set_text("")
	yield(FadeScreen, "AnimationFinished")
#warning-ignore:return_value_discarded
	get_tree().change_scene(scene)
