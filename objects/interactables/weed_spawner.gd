extends EnemySpawner

@onready var weed = preload("res://entities/enemies/weed_enemy.tscn")

func _ready() -> void:
	nav_mesh = get_tree().get_root().get_node("dev_map/WeedNavRegion").navigation_mesh


func spawn_enemy(health) -> Enemy:
	var e:Enemy
	e = weed.instantiate()
	# var e:Enemy = enemy.instantiate()
	enemies_parent_node.add_child(e)
	e.position = global_position
	e.health = health
	e.navmesh = nav_mesh
	return e
