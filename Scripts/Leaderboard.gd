extends Control


func reload_leaderboard(num = 16):
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")

		$Panel/LeaderboardNames.text = ""
		$Panel/LeaderboardTimes.text = ""

		var num_of_scores = SilentWolf.Scores.scores.size()

		var amount = num if num != 0 else num_of_scores

		for i in amount:
			var score = SilentWolf.Scores.scores[num_of_scores - i - 1]
			$Panel/LeaderboardNames.text += score.player_name + "\n"
			$Panel/LeaderboardTimes.text += _to_time(score.score) + "\n"
	else:
		$Panel/Leaderboard.text = "Error: You are not using a build with my api keys so the leaderboard will not work."


func _to_time(seconds):
	var minutes = floor(seconds / 60)
	seconds = seconds - (minutes * 60)

	return str(minutes) + "m " + str(seconds) + "s"
