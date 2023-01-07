@tool
extends MeshInstance3D


func _ready() -> void:
	for index in mesh.get_surface_count():
		var material := mesh.surface_get_material(index)
		if material != null:
			material.texture_filter = 4
