extends KinematicBody2D

# the running speed
export (int) var x_speed = 300 / 4
# the height of a jump at its apex
export (int) var jump_height = 16 * 3
# the x distance of a jump at its apex
export (int) var jump_distance = 16 * 2

# these physics variables will be set in _ready
var gravity = 0
var initial_jump_y_speed = 0
var terminal_velocity = 0

# variables for the shooting mechanic
var can_shoot = true
var is_right = true

# player's current velocity
var velocity = Vector2()

# animation
onready var _animated_sprite = $AnimatedSprite

func _ready():
	# we calculate the acceleration due to gravity
	# as a function of the max jump height and
	# max jump x distance.
	gravity = 2 * jump_height * (x_speed * x_speed)
	gravity /= (jump_distance * jump_distance)

	# same with the initial jump speed.
	initial_jump_y_speed = -2 * jump_height * x_speed
	initial_jump_y_speed /= jump_distance
	
	# the terminal velocity is just set to be twice
	# the initial jump speed. This could also just
	# be an independent parameter.
	terminal_velocity = -2 * initial_jump_y_speed
	
	# start the animation
	_animated_sprite.play()

func get_input(delta):
	if Input.is_action_just_pressed("ui_restart"):
		restart()
	velocity.x = get_floor_velocity().x / 200
	
	var dvx = 0
	var old_right_direction = is_right
	
	# if both directions are pressed in
	# the same frame, don't change directions.
	if Input.is_action_pressed("ui_right"):
		dvx += x_speed
		is_right = true
	if Input.is_action_pressed("ui_left"):
		dvx -= x_speed
		is_right = false
	if dvx == 0:
		is_right = old_right_direction
		set_animation("idle")
	else:
		set_animation("run")
	# flip if facing left
	_animated_sprite.flip_h = !is_right

	velocity.x += dvx

	if is_on_floor() and Input.is_action_just_pressed("ui_select"):
		velocity.y += initial_jump_y_speed
		set_animation("jump_up")
	
	if Input.is_action_just_released("ui_select") and velocity.y < 0:
		velocity.y = 0
	
	if Input.is_action_just_pressed("ui_action") and can_shoot:
		shoot()

func _physics_process(delta):
	get_input(delta)
	velocity.y += gravity * delta
	
	# don't exceed terminal velocity
	# (now, just a function of the jump velocity)
	velocity.y = clamp(velocity.y, -terminal_velocity, terminal_velocity)

	# we change this depending on the platform we're on
	# var ground_normal = Vector2(0, -1)
	velocity = move_and_slide(velocity, Vector2(0, -1), true)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "KillZone":
			restart()
		if collision.collider.name == "Spikes":
			restart()
	
	if velocity.y > 0:
		set_animation("jump_down")

func shoot():

	_animated_sprite.play("shoot")
	var space_state = get_world_2d().direct_space_state
	
	# use global coordinates, not local to node
	var target = self.transform.origin
	if is_right:
		target += Vector2(24, 0)
	else:
		target -= Vector2(24, 0)
	
	var bitmask = 0b00000000000000000001
	var result = space_state.intersect_ray(self.transform.origin, target, [self], bitmask)
	
	if not result:
		can_shoot = false
		get_node("CooldownTimer").start()
		
		var projectile = load("res://prefabs/Orb.tscn")
	
		var orb = projectile.instance()
		orb.transform.origin = self.transform.origin

		var bouncer = orb.get_child(0)
		if is_right:
			bouncer.velocity.x = 1
			orb.transform.origin.x += 16
		else:
			bouncer.velocity.x = -1
			orb.transform.origin.x -= 16
		get_tree().get_root().get_child(0).get_node("OrbManager").add_child(orb)

func restart():
	get_tree().change_scene(get_tree().current_scene.filename)

func _on_CooldownTimer_timeout():
	can_shoot = true
	# maybe disable the timer?

func set_animation(name):
	if _animated_sprite.animation != "shoot":
		_animated_sprite.animation = name

func _on_AnimatedSprite_animation_finished():
	if _animated_sprite.animation == 'shoot':
		_animated_sprite.play('idle')
