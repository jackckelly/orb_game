extends KinematicBody2D


var bouncer = null

func _ready():
	bouncer = get_parent().get_node("Bouncer")

func _process(delta):
	transform.origin = bouncer.transform.origin
	
	var collide = move_and_collide(bouncer.velocity*delta, true, true, true)
	if collide:
		bouncer.bounce_and_snap(collide.normal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
