extends Control


func reload_leaderboard(num = 10):
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")

		$Panel/Leaderboard.text = ""
		var num_of_scores = SilentWolf.Scores.scores.size()

		var amount = num if num != 0 else num_of_scores

		for i in amount:
			if i != 0:
				$Panel/Leaderboard.text += "\n"

			$Panel/Leaderboard.text += (
				SilentWolf.Scores.scores[num_of_scores - i - 1].player_name
				+ " "
				+ _to_time(SilentWolf.Scores.scores[num_of_scores - i - 1].score)
			)
	else:
		$Panel/Leaderboard.text = "Error: You are not using a build with my api keys so the leaderboard will not work."


func _to_time(seconds):
	var minutes = floor(seconds / 60)
	seconds = seconds - (minutes * 60)

	return str(minutes) + "m " + str(seconds) + "s"
