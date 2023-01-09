#this extension of the player class handles zombies specific player stuff

extends Player
class_name MainPlayer

#player specific info
var points:int = 0
var headshots:int = 0
var doors_opened:int = 0

#where the gun is attached to
@onready var gun_spot = $pivot/Camera3D/gun_spot

func get_class():
	return "Player"

#these are deprecated as this logic is handled by the gamemode
func give_weapon(weapon:PackedScene):
	gun_spot.add_child(weapon.instantiate())

#these are deprecated as this logic is handled by the gamemode
func give_points(_points):
	points += _points
	ui_give_money(_points)

func hide_ui():
	$Control.visible = false
	disabled = true
	for x in gun_spot.get_children():
		x.hide_ui()
		x.playing_footstep = true
	
func show_ui():
	$Control.visible = true
	disabled = false
	for x in gun_spot.get_children():
		x.show_ui()
		x.playing_footstep = false

func ui_spend_money(price):
	$Control/buy.play()
	$Control/inventory/Control/lose.text = "-$"+str(price)
	$Control/AnimationPlayer.play("lose_money")

func ui_give_money(price):
	$Control/inventory/Control/gain.text = "+$"+str(price)
	$Control/AnimationPlayer.play("lose_money")

func ui_hit_marker():
	$Control/hit.play()
	$Control/AnimationPlayer.play("hit")

func ui_get_hit(dmg):
	$Control/hurt.play()
	$Control/health/Control/lose.text = "-"+str(dmg)
	$Control/AnimationPlayer.play("get_hit")
