extends Control

var options = ["Music", "Sounds", "Back"]
var index = 0

onready var selections = $HBoxContainer/Selections
onready var music_label = $HBoxContainer/Labels/Music
onready var sounds_label = $HBoxContainer/Labels/Sounds
onready var _sound = get_tree().get_root().get_node("Sound")


func _ready():
	pass

func _process(delta):
	if _sound.is_music_enabled:
		music_label.text = "MUSIC: ON"
	else:
		music_label.text = "MUSIC: OFF"
	
	if _sound.is_fx_enabled:
		sounds_label.text = "SOUNDS: ON"
	else:
		sounds_label.text = "SOUNDS: OFF"
	
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
		_sound.try_play("Menu Select")
		var option = options[index]
		
		if option == "Music":
			_sound.is_music_enabled = !_sound.is_music_enabled
			return
		
		if option == "Sounds":
			_sound.is_fx_enabled = !_sound.is_fx_enabled
			return
		
		if option == "Back":
			get_tree().change_scene("res://StartMenu.tscn")
			return
