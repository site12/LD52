extends Buyable



func purchase_successful(player):
	if player.weapon_levels[player.Weapon.GUN] > 0:
		player.shotgun_node.ammo_in_reserve += 12

func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false
