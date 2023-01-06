##this is a buyable door.

extends Node3D
class_name Door


#export variables for price, any other doors that should open when purchased, and spawners that should
#activate when opened. Also if the door is just a prop or is an actual door.
@export var price:int = 500
@export var linked_doors:Node3D = null 
@export var linked_spawner_1:ZombieSpawner
@export var linked_spawner_2:ZombieSpawner
@export var linked_spawner_3:ZombieSpawner
@export var linked_spawner_4:ZombieSpawner
@export var is_prop:bool = false


#when called, these show or hide the buy door ui 
func show_ui():
	$CanvasLayer.visible = true
func hide_ui():
	$CanvasLayer.visible = false

#this function activates the linked spawners for the next round and gets rid of the stuff blocking the way
func purchase_door():
	print("purchasing door " + name)
	var linked_spawners:Array[ZombieSpawner] = [linked_spawner_1,linked_spawner_2,linked_spawner_3,linked_spawner_4]
	for spawner in linked_spawners:
		if spawner != null:
			spawner.activated = true
	$door_prop.visible = false
	$Area3D/CollisionShape3D.disabled = true
	$StaticBody3D/CollisionShape3D.disabled = true


#sets the text of the UI based on the price and if its a prop it just disables it 
func _ready():
	$CanvasLayer/interact/Label.text = "Hold F to Buy ["+str(price)+"]"
	if is_prop:
		$Area3D/CollisionShape3D.disabled = true
		
		
