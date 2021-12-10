extends Control


func reload_leaderboard(num = 10):
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")

		$Panel/Leaderboard.bbcode_text = "[table=2]"
		var num_of_scores = SilentWolf.Scores.scores.size()

		var amount = num if num != 0 else num_of_scores

		for i in amount:
			$Panel/Leaderboard.bbcode_text += (
				"[cell]"
				+ SilentWolf.Scores.scores[num_of_scores - i - 1].player_name
				+ "[/cell][cell]"
				+ _to_time(SilentWolf.Scores.scores[num_of_scores - i - 1].score)
				+ "[/cell]"
			)
	else:
		$Panel/Leaderboard.text = "Error: You are not using a build with my api keys so the leaderboard will not work."


func _to_time(seconds):
	var minutes = floor(seconds / 60)
	seconds = seconds - (minutes * 60)

	return str(minutes) + "m " + str(seconds) + "s"
