#the seed bag class, extends from gun

extends Gun

func _ready() -> void:
	set_player(get_parent().get_parent().get_parent().get_parent())
	Global.seed_swapped.connect(self.seed_swapped)
	print(Global.seed_swapped.is_connected(self.seed_swapped))
	# seed_swapped()

#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	walk()
	# ammo_count()
	#print(current_state)

func fire_anim():
	$animations/AnimationTree["parameters/playback"].travel("hoeuse_hoe")

func seed_swapped():
	$CanvasLayer/HUD/inventory/Label.text = str(Global.get_seed_type())+" Seeds\n"+ str(player.seeds[Global.selected_seed])
