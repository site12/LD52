extends Node3D

@export var init_color  = Color.WHITE
@export var hoed_color = Color(0.69019609689713, 0.54509806632996, 0.40392157435417)
@export var watered_color = Color(0.41231873631477, 0.31057471036911, 0.2102587223053)

var dirt_colors = {
	"init"  : init_color,
	"hoed" : hoed_color,
	"watered" : watered_color
}

var dirt_state = "init"

func state_change(new_state):
	dirt_state = new_state
	get_node("entity_1_geometry").mesh.surface_0.material.albedo_color = dirt_colors[dirt_state]


