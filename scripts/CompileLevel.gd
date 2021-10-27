tool
extends Node2D

const SwitchMap = preload('res://scripts/SwitchMap.gd')
const CompileMap = preload('res://scripts/CompileMap.gd')

export var compile = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func compile_all():
	for child in self.get_children():
		if child is SwitchMap:
			child.compile_overlay()
			child.get_node('Off').compile()
			child.get_node('On').compile()
		if child is CompileMap:
			child.compile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.editor_hint and compile:
		compile_all()
		compile = false
