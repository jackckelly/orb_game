extends Node2D


# Declare member variables here. Examples:
# var a = 2

var current_level = 0

var levels = [
	"first_steps",
	"a_little_longer",
	"pit",
	"wall",
	"lift",
	"intro_to_absorb",
	"horseshoe",
	"leap_of_faith",
	"shoot_orb_twice",
	"up_and_rebound",
	"first_pass",
	"glass_cage",
	"orb_bounce",
	"3_switch",
	"switch_timer",
	"tricky_switchy",
	"double_jump",
	"pass_timing",
	"over_under",
	"long_way_temp",
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_level(id):
	get_tree().change_scene("res://levels/" + levels[id] + ".tscn")

func next_level():
	current_level += 1
	load_level(current_level)

func display_name(id):
	return levels[id].to_upper().split("_").join(" ")

func display_text(id):
	return str(id + 1) + ". " + display_name(id)
