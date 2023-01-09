#the seed bag class, extends from gun

extends Gun

@onready var seedbag = $Player_Arms/seedbag

var corn_mat = preload("res://objects/weapons/mats/seedbag_corn.tres")
var carrot_mat = preload("res://objects/weapons/mats/seedbag_carrot.tres")
var potato_mat = preload("res://objects/weapons/mats/seedbag_potato.tres")

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
