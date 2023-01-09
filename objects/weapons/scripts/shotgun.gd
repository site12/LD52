#the hoe class, extends from gun

extends Gun
class_name Shotgun

@onready var mat_rust = preload("res://objects/weapons/mats/shotgun_rusty.tres")
@onready var mat_iron = preload("res://objects/weapons/mats/shotgun_iron.tres")
@onready var mat_silver = preload("res://objects/weapons/mats/shotgun_silver.tres")

@onready var upgrades = [mat_rust, mat_iron, mat_silver]

@onready var dam_numbers = [20, 40, 60]


#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	walk()
	ammo_count()
	#print(current_state)

func fire_anim():
	$animations/AnimationTree["parameters/playback"].travel("shotgunshoot")



func update_level(level):
	body_damage = dam_numbers[level-1]
	$Player_Arms/shotgun/MeshInstance3D.set_surface_override_material(0, upgrades[level-1])
