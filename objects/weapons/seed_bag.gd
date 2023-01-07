#the seed bag class, extends from gun

extends Gun

#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	walk()
	ammo_count()
	#print(current_state)

func fire_anim():
	$animations/AnimationTree["parameters/playback"].travel("hoeuse_hoe")

