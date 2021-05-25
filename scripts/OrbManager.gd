extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_orbs = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_child_count() > max_orbs:
		remove_child(get_child(0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
