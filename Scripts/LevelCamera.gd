extends Camera2D

onready var level := get_parent()


func _ready():
	$EndTrigger.connect("body_entered", self, "_end_trigger_entered")
	$DeathArea.connect("body_entered", self, "_death_area_entered")


func _end_trigger_entered(body):
	if body.is_in_group("player"):
		_end_section()


func _end_section():
	if level.next_section():
		_tween_to_next()
	else:
		_end_level()


func _tween_to_next():
	$Tween.interpolate_property(
		self,
		"position",
		position,
		position + level.section_offset,
		1,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)

	$Tween.start()

func _end_level():
	pass

func _death_area_entered(body):
	if body.is_in_group("player"):
		body.die()
