extends Control


func _ready():
	$Leaderboard.reload_leaderboard(0)


func _on_ResetButton_pressed():
	SilentWolf.Scores.wipe_leaderboard()


func _on_SubmitButton_pressed():
	yield(
		SilentWolf.Scores.persist_score("Test", 69, "main", {"deaths": 420}),
		"sw_score_posted"
	)
	$Leaderboard.reload_leaderboard(0)


func _on_ReloadButton_pressed():
	$Leaderboard.reload_leaderboard(0)
