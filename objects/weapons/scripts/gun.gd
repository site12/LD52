#The base gun class

extends Node3D
class_name Gun
#references for the player that owns the weapon, the animation player, and the raycast for dealing damage
@onready var player:MainPlayer = null : set = set_player, get = get_player
@onready var anim_player = $animations/AnimationPlayer
@onready var ray = $RayCast3D

@export var gun_name = "Gun"

#references for sounds, what state the player is currently in, and whether the player is walking or aiming
@export var gunfire = preload("res://objects/weapons/sounds/revolver/revolver_fire.tscn")
@export var dryfire = preload("res://objects/weapons/sounds/revolver/revolver_empty.tscn")
var player_state = ["idle","walking","shooting","aiming","reloading"]
var current_state = player_state[0]
var aiming = false
var walking = false

#gun specific info
@export var max_ammo_in_clip:int = 6
@export var max_ammo_in_reserve:int = 84
var ammo_in_clip:int = max_ammo_in_clip
var ammo_in_reserve:int = max_ammo_in_reserve

#gun damage info
var body_damage:int = 60
var headshot_damage:int = 90

#gets a reference to the player that owns the gun
func _ready():
	set_player(get_parent().get_parent().get_parent().get_parent())

#this function really isn't needed because it will return a nullpointer if called away from a player
func set_player(_player):
	if get_parent().get_parent().get_parent().get_parent() != null:
		player = _player
	else:
		print("error getting player")

#this function returns the owning player
func get_player():
	return player

#this handles firing the weapon, aiming the weapon, and reloading the weapon
func _unhandled_input(event:InputEvent) -> void:
	fire_weapon()
	reload_weapon()
	

#if the player is walking and they aren't shooting or aiming or reloading, set the state to walking.
#if the player isn't doing any of those things then their state is idle
func walk():
	if player.velocity != Vector3.ZERO:
		walking = true
		if current_state == player_state[0]:
			current_state = player_state[1]
	else:
		if current_state == player_state[1]:
			current_state = player_state[0]
		walking = false

#functionality needed
func sprint():
	pass

#functionality needs to be debated
func crouch():
	pass

#handles shooting the weapon
func fire_weapon():
	if Input.is_action_just_pressed("attack") and not current_state == player_state[4]:
		if ammo_in_clip != 0:
			
			#player is shooting
			current_state = player_state[2]
			ammo_in_clip -= 1
			var s = gunfire.instantiate()
			add_child(s)
			print("attacking")
			if ray.is_colliding() and ray.get_collider().get_name().contains("enemy"):
				## apply damage to zombie thru game mode
				player.game_mode.apply_damage_to_zombie(ray.get_collider(),player,body_damage)
		else:
			var s = dryfire.instantiate()
			add_child(s)
			
	if Input.is_action_just_released("attack") and not current_state == player_state[4]:
		#player is finished shooting, return to idle
		if not aiming:
			if not walking:
				current_state = player_state[0]
			else:
				current_state = player_state[1]
		else:
			current_state = player_state[3]

#handles reloading the weapon
func reload_weapon():
	if Input.is_action_just_pressed("reload") and ammo_in_clip != max_ammo_in_clip:
		
		if ammo_in_reserve!=0: 
			
			#player is reloadng
			current_state = player_state[4]
			$CanvasLayer/HUD/cursor.visible = false
			
			
			await get_tree().create_timer(2.5).timeout
			
			#player is finished reloading
			ammo_in_reserve -= max_ammo_in_clip - ammo_in_clip
			ammo_in_clip = max_ammo_in_clip
			if not walking:
				current_state = player_state[0]
			else:
				current_state = player_state[1]
			$CanvasLayer/HUD/cursor.visible = true


	
#updates the ammo count in the HUD
func ammo_count():
	$CanvasLayer/HUD/inventory/Label.text = str(gun_name)+"\n"+ str(ammo_in_clip)+"/"+str(ammo_in_reserve)
	
	


