extends Node2D


# Declare member variables here. Examples:
# var a = 2

var current_level = 0

var levels = [
	"intro_by_the_xx",
	"first_switch",
	"first_steps",
	"a_little_longer",
	"pit",
	"wall",
	"lift",
	"red",
	"horseshoe",
	"leap_of_faith",
	"think_twice",
	"rebound",
	"blue",
	"glass_cage",
	"ricochet",
	"3_switch",
	"timer",
	"tricky_switchy",
	"double_jump",
	"hop",
	"over_under",
	"long_way",
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_level(id):
	current_level = id
	get_tree().change_scene("res://levels/" + levels[id] + ".tscn")

func next_level():
	current_level += 1
	if current_level >= len(levels):
		get_tree().change_scene("res://EndScreen.tscn")
	else:
		load_level(current_level)

func display_name(id):
	return levels[id].to_upper().split("_").join(" ")

func display_text(id):
	return str(id + 1) + ". " + display_name(id)
