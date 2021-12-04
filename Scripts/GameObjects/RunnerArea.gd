extends Area2D

export(String, "right", "left", "jump") var command = "right"


func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	if body.is_in_group("runner"):
		body.call(command)
