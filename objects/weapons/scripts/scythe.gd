#the scyteh class, extends from gun

extends Gun

# var mat_rust = preload("res://objects/weapons/mats/hoe_tool_rust.tres")
# var mat_iron = preload("res://objects/weapons/mats/hoe_tool_iron.tres")
# var mat_silver = preload("res://objects/weapons/mats/hoe_tool_silver.tres")

#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	walk()
	ammo_count()
	#print(current_state)

func fire_anim():
	$animations/AnimationTree["parameters/playback"].travel("scytheattack")

