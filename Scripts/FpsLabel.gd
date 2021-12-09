extends Label

var show = OS.is_debug_build() or OS.has_feature("Debug")

func _ready():
	visible = show

func _process(delta):
	if show:
		text = str(Performance.get_monitor(Performance.TIME_FPS))
