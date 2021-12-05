extends Area2D

export(String, "right", "left", "jump") var command = "right"


func _physics_process(_delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("runner"):
			body.call(command)
