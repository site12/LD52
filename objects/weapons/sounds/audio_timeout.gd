extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready():
	autoplay = false    
	await get_tree().create_timer(get_stream().get_length()).timeout
	self.queue_free()


