#this class is an enemy spawner that when activated will spawn zombies in the next round.

extends Node3D
class_name EnemySpawner

#references for whether it is activated by default or not
@export var activated:bool = false

#references to the enemy and to the navigationmesh on the map
@onready var enemy = preload("res://entities/enemies/enemy.tscn")
@onready var carrot = preload("res://entities/enemies/carrot_enemy.tscn")
@onready var corn = preload("res://entities/enemies/corn_enemy.tscn")
@onready var nav_mesh:NavigationMesh = get_tree().get_root().get_node("dev_map/NavigationRegion3D").navigation_mesh

var enemy_type:Global.SeedType


#gets rid of debug volumes in game
func _ready():
	$spawn_loc.visible = false

#this function will spawn an enemy with a given amount of health at the location of the spawner
func spawn_enemy(health) -> Enemy:
	var e:Enemy
	match enemy_type:
		Global.SeedType.CARROT:
			e = carrot.instantiate()
		Global.SeedType.POTATO:
			e = corn.instantiate()
		Global.SeedType.CORN:
			e = enemy.instantiate()
	# var e:Enemy = enemy.instantiate()
	add_child(e)
	e.health = health
	e.navmesh = nav_mesh
	return e
