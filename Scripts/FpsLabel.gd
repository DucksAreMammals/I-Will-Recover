extends Label


func _process(_delta):
	if Global.debug_mode:
		visible = true
		text = str(Performance.get_monitor(Performance.TIME_FPS))
	else:
		visible = false
