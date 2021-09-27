extends Label

func _ready():
	pass

func _process(delta):
	pass

func _on_BlinkTimer_timeout():
	self.set_visible(!self.visible)

func _on_VisibilityNotifier2D_screen_exited():
	get_node("BlinkTimer").start()
