extends Control


func reload_leaderboard(num = 15):
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")

		$Panel/LeaderboardNames.text = "Name\n"
		$Panel/LeaderboardTimes.text = "Time\n"
		$Panel/LeaderboardDeaths.text = "Deaths\n"

		var num_of_scores = SilentWolf.Scores.scores.size()

		var amount = num if num != 0 and num <= num_of_scores else num_of_scores

		for i in amount:
			var score = SilentWolf.Scores.scores[num_of_scores - i - 1]
			$Panel/LeaderboardNames.text += score.player_name + "\n"
			$Panel/LeaderboardTimes.text += _to_time(score.score) + "\n"
			$Panel/LeaderboardDeaths.text += str(score.metadata["deaths"]) + "\n"
	else:
		$Panel/LeaderboardNames.text = "Error: You are not using a build with my api keys so the leaderboard will not work."


func _to_time(seconds, cutoff = true):
	var minutes = floor(seconds / 60)
	seconds = seconds - (minutes * 60)

	if cutoff:
		return str(minutes) + "m " + str(floor(seconds)) + "s"
	else:
		return str(minutes) + "m " + str(seconds) + "s"
