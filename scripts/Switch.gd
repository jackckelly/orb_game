extends Area2D


enum color_type {WHITE, TAN, PINK, BLUE, GRAY}

export var color = 0

var color_data = {
	0: [0, 1, 'white_on', 'white_off'],
	1: [2, 3, 'tan_on', 'tan_off'],
	2: [4, 5, 'pink_on', 'pink_off'],
	3: [6, 7, 'blue_on', 'blue_off'],
	4: [8, 9, 'gray_on', 'gray_off'],
}

export var on = false

var off_map = null
var on_map  = null
var overlay_off = null
var overlay_on = null 
onready var _animated_sprite = $AnimatedSprite
onready var _sound = get_tree().get_root().get_node("Sound")

func _ready():
	
	off_map = self.get_node("OffMap")
	on_map = self.get_node("OnMap")
	overlay_off = self.get_node("OverlayOff")
	overlay_on = self.get_node("OverlayOn")
	
	if !on:
		self.remove_child(on_map)
		overlay_off.visible = false
	else:
		self.remove_child(off_map)
		overlay_on.visible = false

	connect("body_entered", self, "on_body_entered")
	
	var off_cells = []
	var on_cells = []
	for child_map in off_map.get_children():
		off_cells = off_cells + child_map.get_used_cells()
	
	for child_map in on_map.get_children():
		on_cells = on_cells + child_map.get_used_cells()
	
	for cell in off_cells:
		overlay_off.set_cellv(cell, color_data[color][0])
		overlay_on.set_cellv(cell, color_data[color][1])
	for cell in on_cells:
		overlay_off.set_cellv(cell, color_data[color][1])
		overlay_on.set_cellv(cell, color_data[color][0])
	
	if on:
		_animated_sprite.animation = color_data[color][2]
	else:
		_animated_sprite.animation = color_data[color][3]


func on_body_entered(body):
	on = !on
	
	if on:
		_sound.try_play("Switch On")
		_animated_sprite.animation = color_data[color][2]
	else:
		_sound.try_play("Switch Off")
		_animated_sprite.animation = color_data[color][3]
		

	off_map.visible    = !on
	overlay_off.visible = on
	on_map.visible     =  on
	overlay_on.visible = !on
	
	if on:
		self.remove_child(off_map)
		self.add_child(on_map)
	else:
		self.remove_child(on_map)
		self.add_child(off_map)
