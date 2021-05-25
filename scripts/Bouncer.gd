extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
export var velocity = Vector2()
var accel_elapsed = 0
export var accel_total_duration = 0.3

var collision_angle = deg2rad(90)

func _ready():
	pass
	#print("Shooting projectile")

func _physics_process(delta):
	# set velocity
	accel_elapsed += delta
	var speed = lerp (16 * 12, 16 * 4, clamp(accel_elapsed / accel_total_duration, 0, 1))
	velocity = velocity.normalized() * speed
	
	var collide = move_and_collide(velocity * delta)
	if collide:
		if collide.get_collider().name == "Absorb Blocks":
			#note: this should have a separate animation
			get_parent().get_parent().remove_child(get_parent())
		elif not collide.get_collider().name == "Olauer":
			velocity = velocity.bounce(collide.normal)
			
			# convert into polar coordinates
			var r = velocity.length()
			var theta = velocity.angle()

			# print(rad2deg(theta))
			# round the angle to the nearest multiple of 90 or 45
			var rounded_theta = round (theta / collision_angle) * collision_angle
			print(rounded_theta)
			#print(rad2deg(rounded_theta))
			# print(cos(rounded_theta))

			# convert back to regular coordinates
			velocity = Vector2(cos(rounded_theta) * r, sin(rounded_theta) * r)
			# print(velocity)

func _on_KillTimer_timeout():
	get_parent().get_parent().remove_child(get_parent())

#func _on_MovementTimer_timeout():
#	velocity.x = 64 * 4
