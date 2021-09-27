extends Node2D

var speed = 300 / 4

var wasOnScreen = false

func _ready():
	pass

func _process(delta):
	transform.origin.x += speed * 2.2 * delta

func _on_VisibilityNotifier2D_screen_entered():
	wasOnScreen = true

func _on_VisibilityNotifier2D_screen_exited():
	if wasOnScreen:
		get_parent().remove_child(self)
