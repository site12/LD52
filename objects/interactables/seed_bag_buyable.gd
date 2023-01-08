extends Buyable

@export var seed_type:Global.SeedType

var corn_mat = preload("res://objects/weapons/mats/seedbag_corn.tres")
var carrot_mat = preload("res://objects/weapons/mats/seedbag_carrot.tres")
var potato_mat = preload("res://objects/weapons/mats/seedbag_potato.tres")

func apply_mat():
	if seed_type == Global.SeedType.CORN:
		MeshInstance3D.material_override = corn_mat
	if seed_type == Global.SeedType.CARROT:
		MeshInstance3D.material_override = carrot_mat
	if seed_type == Global.SeedType.POTATO:
		MeshInstance3D.material_override = potato_mat



func purchase_successful(player):
	player.add_seeds(seed_type)
	Global.update_seed_ui()

func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false