extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.56).timeout
	self.queue_free()


