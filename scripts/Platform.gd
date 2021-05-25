extends KinematicBody2D

var bouncer = null

func _ready():
	bouncer = get_parent().get_node("Bouncer")

func _process(delta):
	transform.origin = bouncer.transform.origin
