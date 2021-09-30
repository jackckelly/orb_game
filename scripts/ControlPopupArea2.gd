extends AnimatedSprite

var lock = false

func _ready():
	if len(Input.get_connected_joypads()) == 0:
		self.animation = "keyboard"
	else:
		self.animation = "controller"

	self.set_visible(false)

func _on_ControlPopupArea2_body_entered(body):
	if !lock:
		self.set_visible(true)

func _on_ControlPopupArea2_body_exited(body):
	lock = true
	self.set_visible(false)
