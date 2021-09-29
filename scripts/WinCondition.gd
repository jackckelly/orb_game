extends Area2D


# references
onready var olauer = get_tree().get_root().get_node("Level/Olauer")
onready var _sound = get_tree().get_root().get_node("Sound")
onready var level_manager = get_tree().get_root().get_node("LevelManager")
# states
var in_win_animation = false

# constants
var tip_angle = deg2rad(12)
var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_body_entered")
	
func _process(delta):
	if not in_win_animation:
		return
	
	# spiral animation
	var olauer_to_center = self.global_position - olauer.transform.origin
	
	# we set the orbital velocity
	var orbital_velocity = olauer_to_center.rotated(deg2rad(90) - tip_angle)
	olauer.velocity = olauer.move_and_slide(orbital_velocity * speed, Vector2(0, -1))

func on_body_entered(body):
	# win sound
	_sound.try_play("Win")
	
	# win animation
	var level_switch_timer = get_node("LevelSwitchTimer")
	level_switch_timer.connect("timeout", self, "change_level")
	level_switch_timer.start()
	
	var orbs = get_tree().get_root().get_node('Level/OrbManager')
	
	olauer.is_win_locked = true
	olauer.set_collision_layer(0)
	olauer.set_collision_mask(0)
	in_win_animation = true

func change_level():
	var notifier =  get_tree().get_root().get_node("Level/Olauer/VisibilityNotifier2D")
	olauer.remove_child(notifier)
	level_manager.next_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
