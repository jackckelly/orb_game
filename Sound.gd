extends Node2D

export var is_music_enabled = true
export var is_fx_enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func try_play(name):
	if name == "Background Music":
		if is_music_enabled:
			get_node("Background Music").play()
	elif is_fx_enabled:
		get_node(name).play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
