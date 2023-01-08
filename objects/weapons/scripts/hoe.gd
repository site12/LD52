#the hoe class, extends from gun

extends Gun

@onready var mat_rust = preload("res://objects/weapons/mats/hoe_tool_rust.tres")
@onready var mat_iron = preload("res://objects/weapons/mats/hoe_tool_iron.tres")
@onready var mat_silver = preload("res://objects/weapons/mats/hoe_tool_silver.tres")

@onready var upgrades = [mat_rust, mat_iron, mat_silver]

#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	walk()
	ammo_count()
	#print(current_state)

func get_upgrade_mats():
	pass

func fire_anim():
	$animations/AnimationTree["parameters/playback"].travel("hoeuse_hoe")

func update_level(level):
	$Player_Arms/hoe_tool.set_surface_override_material(0, upgrades[level-1])
