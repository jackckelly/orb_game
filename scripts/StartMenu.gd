extends Control

var options = ["Play", "Level Select", "Options", "Quit"]
var index = 0

onready var selections = $HBoxContainer/Selections

func _ready():
	get_tree().get_root().get_node("Sound").get_node("Startup").play()

func _process(delta):
	if Input.is_action_just_pressed("ui_up") and index > 0:
		get_tree().get_root().get_node("Sound").get_node("Menu Move").play()
		selections.get_child(index).get_child(0).visible = false
		index -= 1
		selections.get_child(index).get_child(0).visible = true

	if Input.is_action_just_pressed("ui_down") and index < options.size() - 1:
		get_tree().get_root().get_node("Sound").get_node("Menu Move").play()
		selections.get_child(index).get_child(0).visible = false
		index += 1
		selections.get_child(index).get_child(0).visible = true
		
	if Input.is_action_just_pressed("ui_accept") or\
	Input.is_action_just_pressed("ui_action"):
		get_tree().get_root().get_node("Sound").get_node("Menu Select").play()
		var option = options[index]
		
		if option == "Play":
			get_tree().change_scene("res://levels/first_steps.tscn")
			get_tree().get_root().get_node("PauseScreen").enabled = true
			get_tree().get_root().get_node("Sound").get_node("Background Music").play()
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
