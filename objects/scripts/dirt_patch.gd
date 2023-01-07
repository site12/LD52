extends Node3D
class_name DirtPatch

@export var init_color  = Color.WHITE
@export var hoed_color = Color(0.69019609689713, 0.54509806632996, 0.40392157435417)
@export var watered_color = Color(0.41231873631477, 0.31057471036911, 0.2102587223053)

var ui_showing = false
var dirt_colors = {
	"init"  : init_color,
	"hoed" : hoed_color,
	"watered" : watered_color
}

var dirt_state = "init"

func get_class(): return "DirtPatch"

func state_change(new_state):
	dirt_state = new_state
	
	var mat = get_node("entity_1_geometry").get_active_material(0).duplicate()
	mat.albedo_color = dirt_colors[dirt_state]
	get_node("entity_1_geometry").set_surface_override_material(0, mat)
	# get_node("entity_1_geometry").get_active_material(0).albedo_color = dirt_colors[dirt_state]
	

func show_ui():
	if not ui_showing:
		$planting_label.text = "Plant " + Global.get_seed_type()
		$planting_label.visible = true
		ui_showing = true

func hide_ui():
	if ui_showing:
		$planting_label.visible = false
		ui_showing = false


