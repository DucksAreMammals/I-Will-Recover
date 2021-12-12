extends CanvasLayer

var show_label = true

func _process(_delta):
	if Global.speedrun_mode and Global.time_valid and show_label:
		$SpeedrunLabel.visible = true
		$SpeedrunLabel.text = Global.to_time(Global.get_time(false))
	else:
		$SpeedrunLabel.visible = false
