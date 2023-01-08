extends Buyable


func purchase_successful(player):
	if player.weapon_levels[player.Weapon.GUN] < 2:
		player.weapon_levels[player.Weapon.GUN] += 1
		player.current_weapon = player.Weapon.GUN
		player.update_weapon()
		


func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false
