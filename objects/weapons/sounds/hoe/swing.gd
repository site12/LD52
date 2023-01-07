extends AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready():
	autoplay = false
	await get_tree().create_timer(0.28).timeout
	self.queue_free()


