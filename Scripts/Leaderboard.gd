extends Control


func _on_SubmitButton_pressed():
	if Global.use_silentwolf:
		var score_id = yield(
			SilentWolf.Scores.persist_score("DucksAreMammals", $TextEdit.text), "sw_score_posted"
		)

		print("Score persisted successfully: " + str(score_id))
		$TextEdit.text = ""


func _on_LoadButton_pressed():
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
		print("Scores: " + str(SilentWolf.Scores.scores))

		$Leaderboard.text = ""

		for score in SilentWolf.Scores.scores:
			$Leaderboard.text += score.player_name + str(score.score) + "\n"
