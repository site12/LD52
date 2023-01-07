#the base class for the playable character

extends CharacterBody3D
class_name Player

#constants for speed and jump stuff
const SPEED = 7.0
const JUMP_VELOCITY = 4.5
enum Weapon {HOE, GUN, WATERING_CAN, SCYTH}

#gets the head pivot and the camera 
@onready var pivot:Node3D = $pivot
@onready var camera:Camera3D = $pivot/Camera3D
@onready var ui_raycast:RayCast3D = $pivot/Camera3D/RayCast3D
@onready var shotgun_node = $pivot/Camera3D/gun_spot/shotgun
@onready var hoe_node = $pivot/Camera3D/gun_spot/hoe

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var attempting_to_interact:bool = true
var interactable_object = null
var last_looked_at = null
var current_weapon = Weapon.HOE


#captures the mouse upon spawn
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
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
		if current_weapon > Weapon.size():
			current_weapon = 0
		update_weapon()

	if Input.is_action_just_released("last_weapon"):
		current_weapon -= 1
		if current_weapon == -1:
			current_weapon = Weapon.size()
		update_weapon()

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
		if target.get_class() == "DirtPatch":
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
			if current_weapon == Weapon.HOE:
				object.state_change("hoed")
		#if object is door
		if object.is_in_group("doors") and attempting_to_interact:
			pass
		
func update_weapon():
	var gun_spot = $pivot/Camera3D/gun_spot
	for weapon in $pivot/Camera3D/gun_spot.get_children():
		gun_spot.remove_child(weapon)
	match current_weapon:
		Weapon.HOE:
			gun_spot.add_child(hoe_node)
			# $pivot/Camera3D/gun_spot/hoe.active = true
			# $pivot/Camera3D/gun_spot/hoe.pause = false
		Weapon.GUN:
			gun_spot.add_child(shotgun_node)
			# $pivot/Camera3D/gun_spot/shotgun.active = true
			# $pivot/Camera3D/gun_spot/shotgun.pause = false
		

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
