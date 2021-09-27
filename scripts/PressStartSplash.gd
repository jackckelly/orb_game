extends Label

onready var _orbAndOlauerSplash = get_node("../../OrbAndOlauerSplash")

func _ready():
	pass

func _process(delta):
	var left_boundary = self.rect_global_position.x
	var ratio_done = (_orbAndOlauerSplash.transform.origin.x - left_boundary)
	ratio_done /= self.rect_size.x
	ratio_done = clamp(ratio_done, 0, 1)
	self.set_percent_visible(ratio_done)
