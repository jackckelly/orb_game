extends Control

var options = ["Play", "Level Select", "Options", "Quit"]
var index = 0

onready var selections = $HBoxContainer/Selections
onready var _sound = get_tree().get_root().get_node("Sound")

func _ready():
	_sound.try_play("Startup")

func _process(delta):
	if Input.is_action_just_pressed("ui_up") and index > 0:
		_sound.try_play("Menu Move")
		selections.get_child(index).get_child(0).visible = false
		index -= 1
		selections.get_child(index).get_child(0).visible = true

	if Input.is_action_just_pressed("ui_down") and index < options.size() - 1:
		_sound.try_play("Menu Move")
		selections.get_child(index).get_child(0).visible = false
		index += 1
		selections.get_child(index).get_child(0).visible = true
		
	if Input.is_action_just_pressed("ui_accept") or\
	Input.is_action_just_pressed("ui_action"):
		_sound.try_play("Menu Select")
		var option = options[index]
		
		if option == "Play":
			get_tree().change_scene("res://levels/first_steps.tscn")
			get_tree().get_root().get_node("PauseScreen").enabled = true
			_sound.try_play("Background Music")
			return
		
		if option == "Level Select":
			print("level select")
			return
		
		if option == "Options":
			print("options")
			return
			
		if option == "Quit":
			get_tree().quit()
			return
