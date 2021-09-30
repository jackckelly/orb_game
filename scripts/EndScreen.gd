extends Control

onready var _sound = get_tree().get_root().get_node("Sound")

func _ready():
	get_tree().get_root().get_node("PauseScreen").enabled = false
	_sound.get_node("Background Music").stop()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://SplashScreen.tscn")
