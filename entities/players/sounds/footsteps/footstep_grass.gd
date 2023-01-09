extends AudioStreamPlayer3D




func _ready():
	randomize()
	self.pitch_scale = randi_range(1.8,2.07)
	self.play()
