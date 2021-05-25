extends Area2D

var on = false

var off_map = null
var on_map  = null

func _ready():
	off_map = self.find_node("OffMap")
	on_map  = self.find_node("OnMap")
	connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	on = !on
	self.find_node("OffSprite").visible = !on
	self.find_node("OnSprite").visible  =  on

	off_map.visible    = !on
	on_map.visible     =  on
	
	if on:
		get_tree().get_root().remove_child(off_map)
		self.add_child(on_map)
	else:
		get_tree().get_root().remove_child(on_map)
		self.add_child(off_map)
