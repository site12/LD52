extends Node3D


var family:Array[String] = [
	"Mother",
	"Father",
	"Uncle",
	"Aunt",
	"Grandfather",
	"Grandmother",
	"Ex-Wife",
	"Ex-Husband"
]

var descriptor:Array[String] = [
	"estranged",
	"eccentric",
	"lazy",
	"generous",
	"quirky",
	"hard-Working"
	
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_family_member()->String:
	randomize()
	var x = randi_range(0,family.size()-1)
	return family[x]

func get_descriptor()->String:
	randomize()
	var x = randi_range(0,descriptor.size()-1)
	return descriptor[x]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_line_edit_yname_text_submitted(new_text):
	Global.your_name = new_text
	$intro/your_name.visible = false
	$intro/your_farms_name.visible = true


func _on_line_edit_fname_text_submitted(new_text):
	Global.farm_name = new_text
	$intro/your_farms_name.visible = false
	$intro/your_pets_name.visible = true


func _on_line_edit_pname_text_submitted(new_text):
	Global.cat_name = new_text
	$intro/your_pets_name.visible = false
	$intro/intro_anim.visible = true
	var text = "Dear "+str(Global.your_name)+",\n\nWe are writing to inform you that you have been selected to acquire a small property from your "+get_descriptor()+" "+get_family_member()+" in their will. This property contains a small farm on it named "+Global.farm_name+". Their only wish is for you to maintain the farm, and keep it from becoming overgrown. Good luck!\n\nBest Regards,\n\nPleasant Valley Planning District"
	$intro/intro_anim/middle/HBoxContainer/description.text = text
	$props/arch.set_farm_name(Global.farm_name)
	$props/arch2.set_farm_name(Global.farm_name)
	await get_tree().create_timer(17).timeout
	var player = load("res://entities/players/player.tscn").instantiate()
	player.global_transform = $intro/spawn_loc.global_transform
	add_child(player)
	$intro.queue_free()
