extends Control


func _ready():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	FadeScreen.fade_out_fast()
	FadeScreen.set_text("")
	_load_leaderboard()


func _load_leaderboard():
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")

		$Leaderboard.text = ""

		for score in SilentWolf.Scores.scores:
			$Leaderboard.text += score.player_name + " " + _to_time(score.score) + "\n"
	else:
		$Leaderboard.text = "Error: You are not using a build with my api keys so the leaderboard will not work."


func _to_time(seconds):
	var minutes = floor(seconds / 60)
	seconds = seconds - (minutes * 60)

	return str(minutes) + "m " + str(seconds) + "s"
