extends Node3D


func _ready():
	set_farm_name(Global.farm_name) 

func set_farm_name(farm_name):
	$label1.text = farm_name
	$label2.text = farm_name
