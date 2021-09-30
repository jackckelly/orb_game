extends Node2D

onready var _orb_manager = $OrbManager
onready var _clear_button = $ClearButton

var lock = false

func _ready():
	if len(Input.get_connected_joypads()) == 0:
		_clear_button.animation = "keyboard"
	else:
		_clear_button.animation = "controller"

func _process(delta):
	if not lock and _orb_manager.get_child_count() >= _orb_manager.max_orbs:
		_clear_button.visible = true
		_clear_button.get_node("Timer").start()
		lock = true

func _on_Timer_timeout():
	_clear_button.set_visible(false)
	pass
