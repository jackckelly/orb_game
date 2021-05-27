extends Area2D

var on = false

var off_map = null
var on_map  = null
onready var _animated_sprite = $AnimatedSprite

func _ready():
	off_map = self.find_node("OffMap")
	on_map  = self.find_node("OnMap")
	connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	on = !on
	
	if on:
		_animated_sprite.animation = "on"
	else:
		_animated_sprite.animation = "off"
		

	off_map.visible    = !on
	on_map.visible     =  on
	
	if on:
		self.remove_child(off_map)
		self.add_child(on_map)
	else:
		self.remove_child(on_map)
		self.add_child(off_map)
