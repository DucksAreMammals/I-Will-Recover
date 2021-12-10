extends CanvasLayer

var paused = false
var can_pause = true


func _process(_delta):
	if Input.is_action_just_pressed("pause") and can_pause:
		if paused:
			_unpause()
		else:
			_pause()

	if paused and not can_pause:
		$AnimationPlayer.play("Fade Out", -1, 1.0, true)
		paused = false


func _pause():
	paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	$AnimationPlayer.play("Fade In")
	$Control/Panel/ResumeButton.grab_focus()


func _unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$AnimationPlayer.play("Fade Out")
	yield($AnimationPlayer, "animation_finished")
	paused = false
	get_tree().paused = false


func _on_ResumeButton_pressed():
	_unpause()
