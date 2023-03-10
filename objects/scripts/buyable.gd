extends Node3D
class_name Buyable


@export var price = 500

enum buyable_type {PURCHASE,UPGRADE,MAX}

@export var current_type = buyable_type.PURCHASE

@onready var highlight:StandardMaterial3D = preload("res://objects/interactables/materials/highlight.tres")


func _ready():
	update_label()
	apply_mat()

func purchase(player):
	if Global.spend_money(price):
		purchase_successful(player)
		player.ui_spend_money(price)
		

func update_label():
	
	match current_type:
		buyable_type.PURCHASE:
			$Control/VBoxContainer/Label.text = "Press F to Purchase [cost: " + str(price)+"]"
		buyable_type.UPGRADE:
			$Control/VBoxContainer/Label.text = "Press F to Upgrade [cost: " + str(price)+"]"
		buyable_type.MAX:
			$Control/VBoxContainer/Label.text = "Max Level"


func apply_mat():
	pass

func purchase_successful(player):
	pass

func get_class():
	return("Buyable")

func show_ui():
	$Control.visible = true
	$MeshInstance3D.material_overlay = highlight
	

func hide_ui():
	$Control.visible = false
	$MeshInstance3D.material_overlay = null
