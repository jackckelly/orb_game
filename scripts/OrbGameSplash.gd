extends Label

onready var _orbAndOlauerSplash = get_node("../../OrbAndOlauerSplash")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var left_boundary = self.rect_global_position.x
	var ratio_done = (_orbAndOlauerSplash.transform.origin.x - left_boundary)
	ratio_done /= self.rect_size.x * 3.45
	ratio_done = clamp(ratio_done, 0, 1)
	self.set_percent_visible(ratio_done)
