#the seed bag class, extends from gun

extends Gun

@onready var seedbag = $Player_Arms/seedbag

var corn_mat = preload("res://objects/weapons/mats/seedbag_corn.tres")
var carrot_mat = preload("res://objects/weapons/mats/seedbag_carrot.tres")
var potato_mat = preload("res://objects/weapons/mats/seedbag_potato.tres")


func hide_ui():
	$CanvasLayer.visible = false
func show_ui():
	$CanvasLayer.visible = true

func _ready() -> void:
	set_player(get_parent().get_parent().get_parent().get_parent())
	Global.seed_swapped.connect(self.seed_swapped)
	# print(Global.seed_swapped.is_connected(self.seed_swapped))
	# seed_swapped()

#this handles the animations every frame and handles the player state and updates the ammo count
func _physics_process(delta):
	walk()
	# ammo_count()
	#print(current_state)

func fire_anim():
	if interactable_object != null:
		if interactable_object.get_class() == "DirtPatch":
				if player.seeds[Global.selected_seed] > 0:
					if interactable_object.plant(Global.selected_seed):
						player.seeds[Global.selected_seed] -= 1
						Global.update_seed_ui()
						var s = gunfire.instantiate()
						add_child(s)
						
	$animations/AnimationTree["parameters/playback"].travel("hoeuse_hoe")
	await get_tree().create_timer($animations/AnimationPlayer.get_animation("hoe/use_hoe").length).timeout
	weapon_state = WeaponState.READY

func seed_swapped():
	$CanvasLayer/HUD/inventory/Label.text = str(Global.get_seed_type())+" Seeds\n"+ str(player.seeds[Global.selected_seed])
	if Global.selected_seed == Global.SeedType.CORN:
		seedbag.material_override = corn_mat
	if Global.selected_seed == Global.SeedType.CARROT:
		seedbag.material_override = carrot_mat
	if Global.selected_seed == Global.SeedType.POTATO:
		seedbag.material_override = potato_mat


#handles shooting the weapon
func fire_weapon():
	weapon_state = WeaponState.USING
	if infinite_ammo != true:
		ammo_in_clip -= 1

	fire_anim()
	
	#var s = gunfire.instantiate()
	#add_child(s)
	#print("attacking")
	#if ray.is_colliding() and ray.get_collider().get_name().contains("enemy"):
		#ray.get_collider().take_damage(body_damage)

