#the scyteh class, extends from gun

extends Gun

@onready var mat_rust = preload("res://objects/weapons/mats/scythe_tool_rust.tres")
@onready var mat_iron = preload("res://objects/weapons/mats/scythe_tool_iron.tres")
@onready var mat_silver = preload("res://objects/weapons/mats/scythe_tool_silver.tres")

@onready var upgrades = [mat_rust, mat_iron, mat_silver]

@onready var dam_numbers = [20, 40, 60]

@onready var starting_name = gun_name
#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	walk()
	ammo_count()
	#print(current_state)

func hide_ui():
	$CanvasLayer.visible = false
func show_ui():
	$CanvasLayer.visible = true

func fire_anim():
	$animations/AnimationTree["parameters/playback"].travel("scytheattack")
	await get_tree().create_timer($animations/AnimationPlayer.get_animation("scythe/attack").length).timeout
	weapon_state = WeaponState.READY

func update_level(level):
	body_damage = dam_numbers[level-1]
	$Player_Arms/scythe_tool.set_surface_override_material(0, upgrades[level-1])
	if body_damage == dam_numbers[0]:
		gun_name = "Rusty "+ starting_name
	if body_damage == dam_numbers[1]:
		gun_name = "Iron "+ starting_name
	if body_damage == dam_numbers[2]:
		gun_name = "Silver "+ starting_name
