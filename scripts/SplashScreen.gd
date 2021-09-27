extends Control

onready var _sound = get_tree().get_root().get_node("Sound")

# Called when the node enters the scene tree for the first time.
func _ready():
	_sound.try_play("Startup")
	
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_sound.try_play("Menu Select")
		get_tree().change_scene("res://StartMenu.tscn")
	pass
