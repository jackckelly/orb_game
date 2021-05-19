extends KinematicBody2D

# the running speed
export (int) var x_speed = 200
# the height of a jump at its apex
export (int) var jump_height = 200
# the x distance of a jump at its apex
export (int) var jump_distance = 100

# these physics variables will be set in _ready
var gravity = 0
var initial_jump_y_speed = 0

# player's current velocity
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity = 2 * jump_height * (x_speed * x_speed)
	gravity /= (jump_distance * jump_distance)
	initial_jump_y_speed = -2 * jump_height * x_speed
	initial_jump_y_speed /= jump_distance

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += x_speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= x_speed
	if is_on_floor() and Input.is_action_pressed("ui_select"):
		velocity.y += initial_jump_y_speed
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	# we change this depending on the platform we're on
	# var ground_normal = Vector2(0, -1)
	velocity = move_and_slide(velocity, Vector2(0, -1), true)
