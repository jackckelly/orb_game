extends Area2D

var on = false

var off_map = null
var on_map  = null
onready var _animated_sprite = $AnimatedSprite
onready var _sound = get_tree().get_root().get_node("Sound")

func _ready():
	
	off_map = self.get_node("OffMap")
	on_map = self.get_node("OnMap")
	self.remove_child(on_map)
	connect("body_entered", self, "on_body_entered")
	
	"""
	var occupied_cells = []
	for child_map in off_map.get_children():
		occupied_cells = occupied_cells + off_map.get_used_cells()
	
	var overlay_off = self.get_node("OverlayOff")
	for cell in occupied_cells:
		#overlay_off.set_cellv()
	
	var on_map_tiles = on_map.get_used_tiles()
	var off_map_tiles = off_map.get_used_tiles()



	"""

func on_body_entered(body):
	on = !on
	
	if on:
		_sound.try_play("Switch On")
		_animated_sprite.animation = "on"
	else:
		_sound.try_play("Switch Off")
		_animated_sprite.animation = "off"
		

	off_map.visible    = !on
	on_map.visible     =  on
	
	if on:
		self.remove_child(off_map)
		self.add_child(on_map)
	else:
		self.remove_child(on_map)
		self.add_child(off_map)
