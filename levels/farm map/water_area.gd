extends Area3D

signal water_entered
signal water_exited

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	water_entered.connect(get_tree().get_root().get_node("dev_map/player").water_area_entered)
	water_exited.connect(get_tree().get_root().get_node("dev_map/player").water_area_exited)
	# print(water_exited.is_connected(get_tree().get_root().get_node("dev_map/player").water_area_exited))




func _on_body_exited(body:Node3D) -> void:
	if body.name == "player":
		water_exited.emit()

func _on_body_entered(body:Node3D) -> void:
	if body.name == "player":
		water_entered.emit()
