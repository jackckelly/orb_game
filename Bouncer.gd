extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
export var velocity = Vector2()

func _ready():
	print("Shooting projectile")

	velocity.x *= 64 * 8


func _physics_process(delta):
	var collide = move_and_collide(velocity * delta)
	if collide and not collide.get_collider().name == "Olauer":
		velocity = velocity.bounce(collide.normal)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_KillTimer_timeout():
	get_parent().get_parent().remove_child(get_parent())


func _on_MovementTimer_timeout():
	velocity.x = 64 * 4
