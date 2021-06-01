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
		# once all menu options are available,
		# we can uncomment this.
		# _sound.try_play("Menu Select")
		var option = options[index]
		
		if option == "Play":
			get_tree().change_scene("res://levels/first_steps.tscn")
			get_tree().get_root().get_node("PauseScreen").enabled = true
			_sound.try_play("Menu Select")
			_sound.try_play("Background Music")
			return
		
		if option == "Level Select":
			_sound.try_play("Orb Wiff")
			return
		
		if option == "Options":
			_sound.try_play("Orb Wiff")
			return
			
		if option == "Quit":
			if OS.get_name() == "HTML5":
				_sound.try_play("Orb Wiff")
			else:
				_sound.try_play("Menu Select")
				get_tree().quit()
