extends Area3D

signal wood_entered
signal wood_exited

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wood_entered.connect(get_tree().get_root().get_node("dev_map/player").wood_area_entered)
	wood_exited.connect(get_tree().get_root().get_node("dev_map/player").wood_area_exited)
	# print(water_exited.is_connected(get_tree().get_root().get_node("dev_map/player").water_area_exited))




func _on_body_exited(body:Node3D) -> void:
	if body.name == "player":
		wood_exited.emit()

func _on_body_entered(body:Node3D) -> void:
	if body.name == "player":
		wood_entered.emit()
