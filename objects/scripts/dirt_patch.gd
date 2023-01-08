extends Node3D
class_name DirtPatch

enum GrowthState {
	RAW,
	TILLED,
	PLANTED,
	GROWTH_0,
	GROWTH_1,
	GROWTH_2,
}

const GROWTH_TIMES = {
	Global.SeedType.CARROT : [5, 10, 20, 30],
	Global.SeedType.POTATO : [5, 15, 40, 60],
	Global.SeedType.CORN : [5, 15, 40, 60]
}

@export var init_color  = Color.WHITE
@export var tilled_color = Color(0.69019609689713, 0.54509806632996, 0.40392157435417)
@export var watered_color = Color(0.41231873631477, 0.31057471036911, 0.2102587223053)

var watered:bool = false
var fertilized:bool = false
var growth_state:GrowthState = GrowthState.RAW

var crop_planted:Global.SeedType

var ui_showing = false
var dirt_colors = {
	"raw"  : init_color,
	"tilled" : tilled_color,
	"watered" : watered_color
}

var dirt_state = "raw"

func get_class(): return "DirtPatch"

func hoe():
	if growth_state == GrowthState.RAW:
		growth_state = GrowthState.TILLED
		var mat = get_node("entity_1_geometry").get_active_material(0).duplicate()
		mat.albedo_color = dirt_colors["tilled"]
		get_node("entity_1_geometry").set_surface_override_material(0, mat)
		$seed_mound.set_surface_override_material(0, mat)

func water():
	if growth_state != GrowthState.RAW:
		watered = true
		var mat = get_node("entity_1_geometry").get_active_material(0).duplicate()
		mat.albedo_color = dirt_colors["watered"]
		get_node("entity_1_geometry").set_surface_override_material(0, mat)
		$seed_mound.set_surface_override_material(0, mat)

func plant(seedtype:Global.SeedType):
	if growth_state == GrowthState.TILLED:
		growth_state = GrowthState.PLANTED
		crop_planted = seedtype
		$seed_mound.visible = true
		apply_plant_texture()
		var t = GROWTH_TIMES[crop_planted]
		var g1_timer = get_tree().create_timer(t[0])
		g1_timer.timeout.connect(growth_stage_1)
		var g2_timer = get_tree().create_timer(t[1])
		g2_timer.timeout.connect(growth_stage_2)
		var g3_timer = get_tree().create_timer(t[2])
		g3_timer.timeout.connect(growth_stage_3)
		var done_timer = get_tree().create_timer(t[3])
		done_timer.timeout.connect(plant_done)

func growth_stage_1():
	$seed_mound.visible = false
	$growth_stages/Growth_1.visible = true
func growth_stage_2():
	$growth_stages/Growth_1.visible = false
	$growth_stages/Growth_2.visible = true
func growth_stage_3():
	$growth_stages/Growth_2.visible = false
	$growth_stages/Growth_3.visible = true


func plant_done():
	$growth_stages/Growth_3.visible = false
	var health
	match crop_planted:
		Global.SeedType.CARROT:
			health = 10
		Global.SeedType.POTATO:
			health = 25
		Global.SeedType.CORN:
			health = 15
	if watered: health *= 1.5
	if fertilized: health *= 1.5
	$enemy_spawner.spawn_enemy(health)
	reset_dirt()



func reset_dirt():
	watered = false
	fertilized = false
	growth_state = GrowthState.RAW

	var mat = get_node("entity_1_geometry").get_active_material(0).duplicate()
	mat.albedo_color = dirt_colors["raw"]
	get_node("entity_1_geometry").set_surface_override_material(0, mat)
	$seed_mound.set_surface_override_material(0, mat)

	for stage in $growth_stages.get_children():
		for crop in stage.get_children(): crop.visible = false
		stage.visible = false



		


			

# func state_change(new_state):
# 	dirt_state = new_state
	
	
	# get_node("entity_1_geometry").get_active_material(0).albedo_color = dirt_colors[dirt_state]
func apply_plant_texture():
	match crop_planted:
		Global.SeedType.CARROT:
			$growth_stages/Growth_1/carrot_growth_1.visible = true
			$growth_stages/Growth_2/carrot_growth_2.visible = true
			$growth_stages/Growth_3/carrot_growth_3.visible = true

func show_ui():
	if not ui_showing:
		if growth_state == GrowthState.RAW:
			$planting_label.text = "Hoe"
		# $planting_label.text = "Plant " + Global.get_seed_type()
		$planting_label.visible = true
		ui_showing = true

func hide_ui():
	if ui_showing:
		$planting_label.visible = false
		ui_showing = false


