#the base class for the playable character

extends CharacterBody3D
class_name Player

#constants for speed and jump stuff
const SPEED = 7.0
const JUMP_VELOCITY = 4.5
enum Weapon {HOE, GUN, WATERING_CAN, SEEDBAG, SCYTHE}

#gets the head pivot and the camera 
@onready var pivot:Node3D = $pivot
@onready var camera:Camera3D = $pivot/Camera3D
@onready var ui_raycast:RayCast3D = $pivot/Camera3D/RayCast3D
@onready var shotgun_node = $pivot/Camera3D/gun_spot/shotgun
@onready var hoe_node = $pivot/Camera3D/gun_spot/hoe
@onready var watering_can_node = $pivot/Camera3D/gun_spot/watering_can
@onready var seedbag_node = $pivot/Camera3D/gun_spot/seedbag
@onready var scythe_node = $pivot/Camera3D/gun_spot/scythe

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var attempting_to_interact:bool = true
var interactable_object = null
var last_looked_at = null
var current_weapon = Weapon.HOE

@onready var seeds = {
	Global.SeedType.CARROT : 0,
	Global.SeedType.POTATO : 0,
	Global.SeedType.CORN : 0
}

@onready var weapon_levels = {
	Weapon.HOE : 1,
	Weapon.GUN : 0,
	Weapon.WATERING_CAN : 0,
	Weapon.SEEDBAG : 1,
	Weapon.SCYTHE : 0
}

#captures the mouse upon spawn
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$pivot/Camera3D/gun_spot/seedbag.seed_swapped()
	Global.update_money.connect(update_money)
	update_money()
	update_weapon()
	

#sets the mouse as visible if esc is pressed and handles rotating the camera
func _unhandled_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * 0.005)
			camera.rotate_x(-event.relative.y * 0.005)
			camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-80),deg_to_rad(80))


	# Changing weapon
	if Input.is_action_just_released("next_weapon"):
		current_weapon += 1
		if current_weapon >= Weapon.size():
			current_weapon = 0
		while weapon_levels[current_weapon] == 0:
			current_weapon += 1
			if current_weapon >= Weapon.size():
				current_weapon = 0
		# current_weapon += 1
		# while current_weapon not in weapon_inv:
		# 	current_weapon += 1
		# 	if current_weapon >= Weapon.size():
		# 		current_weapon = 0

		#-----------------------------------------
		# if weapon_levels[current_weapon] == 0:
		# 	current_weapon += 1
		# if current_weapon >= Weapon.size():
		# 	current_weapon = 0
		update_weapon()

	if Input.is_action_just_released("last_weapon"):
		current_weapon -= 1
		if current_weapon == -1:
			current_weapon = Weapon.size()-1
		while weapon_levels[current_weapon] == 0:
			current_weapon -= 1
			if current_weapon == -1:
				current_weapon = Weapon.size()-1
		# if weapon_levels[current_weapon] == 0:
		# 	current_weapon -= 1
		# if current_weapon == -1:
		# 	current_weapon = Weapon.size()-1
		update_weapon()

	if Input.is_action_just_pressed("swap_seed"):
		Global.swap_seed()

	if Input.is_action_just_pressed("interact"):
		if ui_raycast.is_colliding():
			var target = ui_raycast.get_collider().get_parent()
			if target.get_class() == "Buyable":
				target.purchase(self)
		

	handle_interactions()

#handles interacting with windows
func handle_interactions()->void:
	if Input.is_action_just_pressed("attack"):
		attempting_to_interact = true
		attempt_to_interact(interactable_object)
		print(interactable_object)
		
	if Input.is_action_just_released("attack"):
		attempting_to_interact = false
		if interactable_object != null:
			if interactable_object.is_in_group("windows"):
				interactable_object.repair_timer.stop()

#handles basic input
func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# checking for hover over planting plots
	if ui_raycast.is_colliding():
		var target = ui_raycast.get_collider().get_parent()
		if last_looked_at and target != last_looked_at:
			last_looked_at.hide_ui()
			last_looked_at = null	
		if target.get_class() == "DirtPatch":
			target.show_ui()
			interactable_object = target
			last_looked_at = target
		elif target.get_class() == "Buyable":
			target.show_ui()
			interactable_object = target
			last_looked_at = target
		elif last_looked_at:
			last_looked_at.hide_ui()
			last_looked_at = null	
	elif last_looked_at:
		last_looked_at.hide_ui()
		last_looked_at = null

	
	
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_backward","move_forward","move_left","move_right")
	var direction = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

#returns player's location in the world
func get_player_location() -> Vector3:
	return global_transform.origin

#handles attempting to interact with an object
func attempt_to_interact(object):
	if object != null:
		if object.get_class() == "DirtPatch":
			match current_weapon:
				Weapon.HOE:
					object.hoe()
				Weapon.WATERING_CAN:
					object.water()
				Weapon.SEEDBAG:
					if seeds[Global.selected_seed] > 0:
						if object.plant(Global.selected_seed):
							seeds[Global.selected_seed] -= 1
							Global.update_seed_ui()
					
		#if object is door
		if object.is_in_group("doors") and attempting_to_interact:
			pass
		
func update_weapon():
	var gun_spot = $pivot/Camera3D/gun_spot
	for weapon in $pivot/Camera3D/gun_spot.get_children():
		gun_spot.remove_child(weapon)
	match current_weapon:
		Weapon.HOE:
			hoe_node.update_level(weapon_levels[Weapon.HOE])
			gun_spot.add_child(hoe_node)
		Weapon.GUN:
			shotgun_node.update_level(weapon_levels[Weapon.GUN])
			gun_spot.add_child(shotgun_node)
		Weapon.WATERING_CAN:
			watering_can_node.update_level(weapon_levels[Weapon.WATERING_CAN])
			gun_spot.add_child(watering_can_node)
		Weapon.SEEDBAG:
			gun_spot.add_child(seedbag_node)
		Weapon.SCYTHE:
			scythe_node.update_level(weapon_levels[Weapon.SCYTHE])
			gun_spot.add_child(scythe_node)
		
func add_seeds(seedtype:Global.SeedType):
	seeds[seedtype] +=1

func update_money():
	$Control/inventory/Label.text = "$"+str(Global.money)

func ui_spend_money(price):
	pass
func ui_give_money(price):
	pass

# #allows us to attempt to interact when an object enters our interact radius
# func _on_interactable_area_area_entered(area):
# 	print(area)
# 	#if door
# 	if area.get_parent().is_in_group("doors"):
# 		interactable_object = area.get_parent()
# 		print("interactable is door")
# 		area.get_parent().show_ui()

# #prevents us from interacting further with the object 
# func _on_interactable_area_area_exited(area):
# 	print(area)
# 	# if window

# 	#if door
# 	if area.get_parent().is_in_group("doors"):
# 		area.get_parent().hide_ui()
# 		print("no longer interacting with door")
# 	interactable_object = null
