#this extension of the player class handles zombies specific player stuff

extends Player
class_name MainPlayer

#player specific info
var points:int = 0
var headshots:int = 0
var doors_opened:int = 0

#where the gun is attached to
@onready var gun_spot = $pivot/Camera3D/gun_spot

#these are deprecated as this logic is handled by the gamemode
func give_weapon(weapon:PackedScene):
	gun_spot.add_child(weapon.instantiate())

#these are deprecated as this logic is handled by the gamemode
func give_points(_points):
	points += _points
	ui_give_money(_points)

func ui_spend_money(price):
	$Control/inventory/Control/lose.text = "-$"+str(price)
	$Control/AnimationPlayer.play("lose_money")

func ui_give_money(price):
	$Control/inventory/Control/gain.text = "+$"+str(price)
	$Control/AnimationPlayer.play("lose_money")

func ui_hit_marker():
	$Control/AnimationPlayer.play("hit")
