extends Control


func _ready():
	_load_leaderboard()


func _on_ResetButton_pressed():
	SilentWolf.Scores.wipe_leaderboard()
	yield(get_tree().create_timer(1), "timeout")
	_load_leaderboard()


func _load_leaderboard():
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
		
		$Leaderboard.text = ""

		for score in SilentWolf.Scores.scores:
			$Leaderboard.text += score.player_name + str(score.score) + "\n"
	else:
		$Leaderboard.text = "Error: You are not using a build with my api keys so the leaderboard will not work."
