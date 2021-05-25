extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var nextLevel = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	get_tree().change_scene("res://levels/" + nextLevel + ".tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
