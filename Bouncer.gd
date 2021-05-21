extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
export var velocity = Vector2()
var accel_elapsed = 0
export var accel_total_duration = 0.3

func _ready():
	print("Shooting projectile")

func _physics_process(delta):
	# set velocity
	accel_elapsed += delta
	var speed = lerp (64 * 12, 64 * 4, clamp(accel_elapsed / accel_total_duration, 0, 1))
	velocity = velocity.normalized() * speed
	
	var collide = move_and_collide(velocity * delta)
	if collide and not collide.get_collider().name == "Olauer":
		velocity = velocity.bounce(collide.normal)

func _on_KillTimer_timeout():
	get_parent().get_parent().remove_child(get_parent())

#func _on_MovementTimer_timeout():
#	velocity.x = 64 * 4
