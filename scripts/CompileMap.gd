tool
extends Node2D

var BOUNCING_BLOCK_ID = 0
var ABSORB_BLOCK_ID = 1
var PASS_BLOCK_ID = 2
var SPIKE_ID = 3
var CORNER_ID = 4
var SWITCH_BLACK_ID = 5
var SWITCH_RED_ID = 6
var SWITCH_BLUE_ID = 7
var OVERLAY_ID = 8

var compile = false

func _ready():
	if Engine.editor_hint:
		compile()
	else:
		get_node("Compiled").set_visible(true)
		print("removing edit map")
		self.remove_child(get_node("Edit"))
	
func compile():
	print("compiling map...")
	
	var _edit_map = self.get_node("Edit")
	
	var bouncing_map = get_node("Compiled/Bouncing Blocks")
	var corner_map = get_node("Compiled/Corners")
	var passing_map = get_node("Compiled/Passing Blocks")
	var absorb_map = get_node("Compiled/Absorb Blocks")
	var spike_map = get_node("Compiled/Spikes")
	
	bouncing_map.clear()
	corner_map.clear()
	passing_map.clear()
	absorb_map.clear()
	spike_map.clear()

	for cell_index in _edit_map.get_used_cells():
		var cell_id = _edit_map.get_cellv(cell_index)
		var autotile_id = _edit_map.get_cell_autotile_coord(cell_index.x, cell_index.y)
		match cell_id:
			BOUNCING_BLOCK_ID, SWITCH_BLACK_ID:
				bouncing_map.set_cell(cell_index.x, cell_index.y, cell_id, false, false, false, autotile_id)
			ABSORB_BLOCK_ID, SWITCH_RED_ID:
				absorb_map.set_cell(cell_index.x, cell_index.y, cell_id, false, false, false, autotile_id)
			PASS_BLOCK_ID, SWITCH_BLUE_ID:
				passing_map.set_cell(cell_index.x, cell_index.y, cell_id, false, false, false, autotile_id)
			CORNER_ID:
				corner_map.set_cell(cell_index.x, cell_index.y, cell_id, false, false, false, autotile_id)
			SPIKE_ID:
				spike_map.set_cell(cell_index.x, cell_index.y, cell_id, false, false, false, autotile_id)
	
	print("...done.")
func _process(delta):
	if Engine.editor_hint and compile:
		compile()
		compile = false
