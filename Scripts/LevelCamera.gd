extends Camera2D

var section := 0
var section_max := 4
var section_offset := Vector2(400, 0)


func _ready():
	$EndTrigger.connect("body_entered", self, "_end_trigger_entered")


func _end_trigger_entered(body):
	if body.is_in_group("player"):
		_end_section()


func _end_section():
	if section < section_max:
		section += 1
	else:
		end_level()


func _tween_to_next():
	$Tween.interpolate_property(
		self,
		"position",
		position,
		position + section_offset,
		1,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)

	$Tween.start()

func _end_level():
	pass