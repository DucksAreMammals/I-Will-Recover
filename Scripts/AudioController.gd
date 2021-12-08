extends Node

export var min_music_volume = -30.0


func _ready():
	if Global.music_level != 0:
		$MusicPlayer.volume_db = Global.music_level * .01 * min_music_volume
		$MusicPlayer.play()
