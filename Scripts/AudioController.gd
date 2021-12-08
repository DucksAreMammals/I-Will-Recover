extends Node

export var min_music_volume := -30.0

export(Array, AudioStream) var jump_sounds
export var jump_pitch_shift := [0.9, 1.1]

var play_sfx := true


func _ready():
	if Global.music_level != 0:
		$MusicPlayer.volume_db = (100 - Global.music_level) * 0.01 * min_music_volume
		$MusicPlayer.play()


func play_jump():
	if jump_sounds.size() > 0 and play_sfx:
		$PlayerSoundPlayer.stream = jump_sounds[randi() % jump_sounds.size()]
		$PlayerSoundPlayer.pitch_scale = rand_range(jump_pitch_shift[0], jump_pitch_shift[1])
		$PlayerSoundPlayer.play()
