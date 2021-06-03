extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var level_manager = get_tree().get_root().get_node("LevelManager")
onready var num_levels = len(level_manager.levels)
onready var _sound = get_tree().get_root().get_node("Sound")

onready var scroll = $ScrollContainer
onready var level_display = $ScrollContainer/Levels
onready var select_button = $SelectButton

var index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var level_display = self.get_node("ScrollContainer/Levels")
	for i in range(len(level_manager.levels)):
		var label =  Label.new()
		label.set_focus_mode(2)
		label.text = level_manager.display_text(i)
		level_display.add_child(label)
	var selected = level_display.get_child(0)
	selected.grab_focus()
	select_button.rect_global_position.x = 55
	move_selection(selected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up") and index > 0:
		_sound.try_play("Menu Move")
		index -= 1
		var selected = level_display.get_child(index)
		move_selection(selected)
		selected.grab_focus()

	elif (Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_focus_next")) and index < num_levels - 1:
		_sound.try_play("Menu Move")
		index += 1
		var selected = level_display.get_child(index)
		move_selection(selected)
		selected.grab_focus()
	
	elif (Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up")):
		_sound.try_play("Orb Wiff")
		
	if Input.is_action_just_pressed("ui_accept") or\
	Input.is_action_just_pressed("ui_action"):
		get_tree().get_root().get_node("PauseScreen").enabled = true
		_sound.try_play("Menu Select")
		_sound.try_play("Background Music")
		level_manager.load_level(index)
		

func move_selection(option):
	select_button.rect_global_position.y = option.rect_global_position.y
	

