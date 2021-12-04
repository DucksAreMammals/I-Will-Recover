extends StaticBody2D

var open = false


func _process(delta):
	if open:
		self.position.y += delta * 32


func open_gate():
	open = true
