extends Control


func _ready():
	reload_leaderboard()


func reload_leaderboard():
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")

		$Leaderboard.text = ""
		var num_of_scores = SilentWolf.Scores.scores.size()
		print(num_of_scores)

		for i in 10:
			$Leaderboard.text += (
				SilentWolf.Scores.scores[num_of_scores - i - 1].player_name
				+ " "
				+ _to_time(SilentWolf.Scores.scores[num_of_scores - i - 1].score)
				+ "\n"
			)
	else:
		$Leaderboard.text = "Error: You are not using a build with my api keys so the leaderboard will not work."


func _to_time(seconds):
	var minutes = floor(seconds / 60)
	seconds = seconds - (minutes * 60)

	return str(minutes) + "m " + str(seconds) + "s"
