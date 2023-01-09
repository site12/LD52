extends AudioStreamPlayer3D


var step1 
var step2
var step_count = 0

func _ready():
	randomize()


func activate():
	step1 = randf_range(1.4,1.6)
	step2 = randf_range(1.7,1.95)
	step_count+=1
	
	if step_count % 2 == 0:
		self.pitch_scale = step1
	else:
		self.pitch_scale = step2
	self.play()
