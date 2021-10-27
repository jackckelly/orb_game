tool

extends Node2D


enum color_type {WHITE, TAN, PINK, BLUE, GRAY}

export var color = 0

const color_data = {
	0: [0, 1, 'white_on', 'white_off'],
	1: [2, 3, 'tan_on', 'tan_off'],
	2: [4, 5, 'pink_on', 'pink_off'],
	3: [6, 7, 'blue_on', 'blue_off'],
	4: [8, 9, 'gray_on', 'gray_off'],
}

export var switch_on = false
export var compile_overlay = false

var switch_map = null
var off_map = null
var on_map  = null

#var on_root = null
#var off_root = null
#
var off_overlay = null
var on_overlay = null

onready var _animated_sprite = $AnimatedSprite
onready var _sound = get_tree().get_root().get_node("Sound")

func _ready():

	off_map = self.get_node("Off")
	on_map = self.get_node("On")
	off_overlay = off_map.get_node("Overlay")
	on_overlay = on_map.get_node("Overlay")

	if not Engine.editor_hint: 
		if switch_on:
			self.remove_child(off_map)
			#overlay_off.visible = false
		else:
			self.remove_child(on_map)
			#overlay_on.visible = false
	
	# right now this only handles the tilemaps
	# todo: determine intended behavior for switches/win conditions


func toggle_switch():
	switch_on = !switch_on
	
	if switch_on:
		self.remove_child(off_map)
		self.add_child(on_map)
	else:
		self.remove_child(on_map)
		self.add_child(off_map)

func compile_overlay():
	print('...compiling_overlay')
	off_map = self.get_node("Off")
	on_map = self.get_node("On")
	off_overlay = off_map.get_node("Overlay")
	on_overlay = on_map.get_node("Overlay")
	
	off_overlay.clear()
	on_overlay.clear()

	var off_cells = []
	var on_cells = []
	
	for child_map in off_map.get_node('Compiled').get_children():
		off_cells = off_cells + child_map.get_used_cells()

	for child_map in on_map.get_node('Compiled').get_children():
		on_cells = on_cells + child_map.get_used_cells()

	for cell in off_cells:
		off_overlay.set_cellv(cell, color_data[color][1])
		on_overlay.set_cellv(cell, color_data[color][0])
	for cell in on_cells:
		off_overlay.set_cellv(cell, color_data[color][0])
		on_overlay.set_cellv(cell, color_data[color][1])
		
func _process(delta):
	if Engine.editor_hint and compile_overlay:
		compile_overlay()
		compile_overlay = false
