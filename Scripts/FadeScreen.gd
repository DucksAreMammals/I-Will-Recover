extends CanvasLayer

signal AnimationFinished


func set_text(text):
	$ColorRect/Label.text = text


func fade_in():
	$AnimationPlayer.play("Fade In")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("AnimationFinished")


func fade_out():
	$AnimationPlayer.play("Fade Out")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("AnimationFinished")
