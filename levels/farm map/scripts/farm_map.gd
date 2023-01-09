extends Node3D

const CURVE = 1.1

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

var chosen_family_member = "Ex-Husband"
var chosen_descriptor
var difficulty:float = 1.0
var sim_time = 0
@onready var player_char = $player
@onready var weed_spawners = $weed_spawners.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.start_time = Time.get_ticks_msec()

func get_family_member()->String:
	randomize()
	var x = randi_range(0,family.size()-1)
	if family[x] == chosen_family_member:
		get_family_member()
	chosen_family_member = x
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


func player_death():
	Global.time_elapsed = (Time.get_ticks_msec() - Global.start_time) / 1000
	$dying/scorecard/screen/middle/left/name.text = Global.your_name
	$dying/scorecard/screen/middle/left/farm_name.text = Global.farm_name
	$dying/scorecard/screen/middle/middle/mharvest.text = "Melee Harvests:                   "+str(Global.melee_harvests)
	$dying/scorecard/screen/middle/middle/rharvest.text = "Ranged Harvests:               "+str(Global.ranged_harvests)
	$dying/scorecard/screen/middle/middle/upgrades.text = "Upgrades Purchased:  "+str(Global.upgrades_purchased)+"/9"
	$dying/scorecard/screen/middle/right/time_alive.text = "Time Spent Alive:              "+str(Global.time_elapsed)
	$dying/scorecard/screen/middle/right/steps_taken.text = "Steps Taken:                          "+str(Global.steps)
	$dying/scorecard/screen/middle/right/paths_opened.text = "Paths Opened:                  "+str(Global.pathways_opened)+"/6"
	$dying/scorecard/screen/bottom/HBoxContainer/epilogue2.text = "Unfortunately, you were unable to fulfill your "+chosen_family_member+"'s wishes. Your cat was adopted by your "+get_family_member()+", and the farm had to shut down."
	$dying/scorecard.visible = true


func _on_weed_spawn_timer_timeout() -> void:
	sim_time += 10
	print("time = " + str(sim_time))
	print("Current Difficulty: " + str(difficulty))
	print("Spawning " + str(floor(difficulty)) + " weeds")
	for enemy in range(floor(difficulty)):
		weed_spawners[randi() % weed_spawners.size()].spawn_enemy(15)
	difficulty *= CURVE
