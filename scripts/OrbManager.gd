extends Node2D

export var max_orbs = 2

func _ready():
	pass

func _process(delta):
	if get_child_count() > max_orbs:
		remove_child(get_child(0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
