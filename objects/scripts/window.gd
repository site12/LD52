#base class for barriers, will eventually be abstracted

extends Node3D
class_name Barrier

#references to the boards that the zombies need to remove
@onready var boards:Array = [
	$boards/board_1,
	$boards/board_2,
	$boards/board_3,
	$boards/board_4,
	$boards/board_5,
	$boards/board_6
]
#references to the window's starting health (same amount as num of boards) and the timer that runs when
#repairing
@onready var repair_timer = $repair_timer
@export var window_health = 6

#gets rid of debug volumes in game
func _ready():
	$zombie_target.visible = false

#returns the window object
func get_window()-> Barrier:
	return self

#a zombie will call this to damage the window to allow itself to go through the barrier.
func attack_window(zombie:Zombie,dmg:int):
	if window_health - dmg >= 0:
		window_health -= dmg
		boards[window_health-dmg].visible = false
	else:
		window_health = 0

#returns the window's current health
func get_window_health()->int:
	return window_health

#a player will call this to repair the window by holding the f button
func repair_window(dmg:int):
	if window_health + dmg <6:
		boards[window_health].visible = true
		window_health += dmg
	else:
		window_health = 6
		boards[window_health-1].visible = true
		hide_ui()

#functions for showing and hiding the repair UI
func show_ui():
	$CanvasLayer.visible = true
func hide_ui():
	$CanvasLayer.visible = false

#returns the window's location in the world
func get_window_location() -> Vector3:
	return global_transform.origin

#when the repair timer runs out, the window is repaired by 1 board. 
func _on_repair_timer_timeout():
	repair_window(1)
	print("attempting to repair window "+str(name)+", current health = " + str(window_health))
