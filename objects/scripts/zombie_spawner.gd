#this class is a zombie spawner that when activated will spawn zombies in the next round.

extends Node3D
class_name ZombieSpawner

#references for where the zombie will go and whether it is activated by default or not
@export var linked_window:Node3D = null
@export var activated:bool = false

#references to the zombie and to the navigationmesh on the map
@onready var zombie = preload("res://addons/game-pack-codz/entities/enemies/zombie_1.tscn")
@onready var nav_mesh:NavigationMesh = get_tree().get_root().get_node("zm_tutorial/NavigationRegion3D").navigation_mesh


#gets rid of debug volumes in game
func _ready():
	$spawn_loc.visible = false

#this function will spawn a zombie with a given amount of health at the location of the spawner
func spawn_zombie(health) -> Zombie:
	var z:Zombie = zombie.instantiate()
	z.targeted_window = linked_window
	add_child(z)
	z.health = health
	z.navmesh = nav_mesh
	return z
