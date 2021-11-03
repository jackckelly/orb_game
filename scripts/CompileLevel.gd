tool
extends Node2D

const SwitchMap = preload('res://scripts/SwitchMap.gd')
const CompileMap = preload('res://scripts/CompileMap.gd')

export var compile = false

var eds = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		var ep = EditorPlugin.new()
		eds = ep.get_editor_interface().get_selection()
		eds.connect("selection_changed", self, "_on_selection_changed")

func _on_selection_changed():
	for child in self.get_children():
		if child is SwitchMap:
			child.get_node("Off/Edit").set_modulate(Color(1, 1, 1, 0.5))
			child.get_node("Off/Overlay").set_modulate(Color(1, 1, 1, 0.5))
			child.get_node("On/Edit").set_modulate(Color(1, 1, 1, 0.5))
			child.get_node("On/Overlay").set_modulate(Color(1, 1, 1, 0.5))
		if child is CompileMap:
			child.get_node("Edit").set_modulate(Color(1, 1, 1, 0.5))

	var sel = eds.get_selected_nodes()

	for selected_node in sel:
		if selected_node is TileMap:
			selected_node.set_modulate(Color(1, 1, 1, 1))

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
