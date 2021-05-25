extends Area2D

var on = false

func _ready():
	connect("body_entered", self, "on_body_entered")
	pass # Replace with function body.

func on_body_entered(body):
	on = !on
	self.find_node("OffSprite").visible = !on
	self.find_node("OnSprite").visible = on
