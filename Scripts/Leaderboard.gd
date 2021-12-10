extends Control

signal checked

var has_profanity = false


func _ready():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	FadeScreen.fade_out_fast()
	FadeScreen.set_text("")
# warning-ignore:return_value_discarded
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	_load_leaderboard()
	$TimeLabel.text = (
		_to_time(Global.get_time())
		if Global.get_time() >= 0 and Global.time_valid
		else "Time invalid"
	)


func _on_SubmitButton_pressed():
	if Global.use_silentwolf:
		if Global.get_time() >= 0 and Global.time_valid:
			name = $Name.text
			if name.length() < 20 and name.length() >= 1 and $Name.text != "":
				if name.count("?") + name.count("\n") <= 0:
					_contains_profanity(name)
					yield(self, "checked")
					if not has_profanity:
						$SubmitButton.disabled = true
						yield(
							SilentWolf.Scores.persist_score(name, Global.get_time()),
							"sw_score_posted"
						)
						_load_leaderboard()
					else:
						$ErrorLable.text = "Name must not contains profanity"
				else:
					$ErrorLable.text = "Name must not contain ? or new lines"
			else:
				$ErrorLable.text = "Name must be between 1 and 20 characters"
		else:
			$ErrorLabel.text = "Invalid time"


func _load_leaderboard():
	if Global.use_silentwolf:
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")

		$Leaderboard.text = ""

		for score in SilentWolf.Scores.scores:
			$Leaderboard.text += score.player_name + " " + _to_time(score.score) + "\n"
	else:
		$Leaderboard.text = "Error: You are not using a build with my api keys so the leaderboard will not work."


func _contains_profanity(text):
	$HTTPRequest.request(
		"https://community-purgomalum.p.rapidapi.com/containsprofanity?text=" + text,
		["x-rapidapi-key: 2ef47e3edfmshb9cd5b24f094450p191ef6jsn9b316a05f15e"]
	)
	yield(self, "checked")
	return has_profanity


func _on_request_completed(_result, _response_code, _headers, body):
	var json = JSON.parse(body.get_string_from_utf8()).result
	has_profanity = json
	emit_signal("checked")


func _on_Name_focus_entered():
	Global.can_fullscreen = false


func _on_Name_focus_exited():
	Global.can_fullscreen = true


func _on_Name_text_entered(_new_text):
	_on_SubmitButton_pressed()


func _to_time(seconds):
	var minutes = floor(seconds / 60)
	seconds = seconds - (minutes * 60)

	return str(minutes) + "m " + str(seconds) + "s"
