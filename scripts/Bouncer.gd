extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
export var velocity = Vector2()
var accel_elapsed = 0
export var accel_total_duration = 0.3

var collision_angle = deg2rad(90)
var frames_since_collision = 0
var last_collided = -1

var start_speed = 16 * 5
var end_speed = 16 * 5

func _ready():
	pass
	#print("Shooting projectile")

func _physics_process(delta):
	# set velocity
	frames_since_collision += 1
	accel_elapsed += delta
	var speed = lerp (start_speed, end_speed, clamp(accel_elapsed / accel_total_duration, 0, 1))
	velocity = velocity.normalized() * speed
	
	var collide = move_and_collide(velocity * delta)
	if collide:
		var collider = collide.get_collider()
		if collider.name == "Absorb Blocks":
			#note: this should have a separate animation
			get_parent().get_parent().remove_child(get_parent())
		#elif not collider.name == "Olauer":
		else:
			var new_collided = collider.get_instance_id()
			if new_collided != last_collided or frames_since_collision > 1:
				
				last_collided = new_collided
				frames_since_collision = 0
				
				bounce_and_snap(collide.normal)

func bounce_and_snap(normal):
	velocity = velocity.bounce(normal)

	# convert into polar coordinates
	var r = velocity.length()
	var theta = velocity.angle()

	# round the angle to the nearest multiple of 90 or 45
	var rounded_theta = round (theta / collision_angle) * collision_angle

	# convert back to regular coordinates
	velocity = Vector2(cos(rounded_theta) * r, sin(rounded_theta) * r)

func _on_KillTimer_timeout():
	get_parent().get_parent().remove_child(get_parent())

#func _on_MovementTimer_timeout():
#	velocity.x = 64 * 4
