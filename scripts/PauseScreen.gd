extends PopupPanel

var enabled = false

func _process(delta):
	if enabled and Input.is_action_just_pressed("ui_accept"):
		var was_paused = get_tree().paused

		if was_paused:
			self.hide()
		else:
			self.popup()

		get_tree().paused = !was_paused
