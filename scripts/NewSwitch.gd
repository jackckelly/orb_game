extends Area2D

const SwitchMap = preload("res://scripts/SwitchMap.gd")

onready var _animated_sprite = $AnimatedSprite

var switch_map = null
export var switch_map_name = 'SwitchMap'
# Called when the node enters the scene tree for the first time.
func _ready():
	switch_map = get_tree().get_root().get_node("Level").get_node(switch_map_name)
	connect("body_entered", self, "on_body_entered")

func update_appearance():	
	if switch_map.switch_on:
		_animated_sprite.animation = SwitchMap.color_data[switch_map.color][2]
	else:
		_animated_sprite.animation = SwitchMap.color_data[switch_map.color][3]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_body_entered(body):
	switch_map.toggle_switch()
	update_appearance()
