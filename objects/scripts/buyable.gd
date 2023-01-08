extends Node3D
class_name Buyable


@export var price = 500

func _ready():
	$Control/VBoxContainer/Label.text = "Press F to Purchase [cost: " + str(price)+"]"

func purchase(player):
	if Global.spend_money(price):
		purchase_successful(player)

func purchase_successful(player):
	pass

func get_class():
	return("Buyable")

