extends Buyable


func purchase_successful(player):
	if player.weapon_levels[player.Weapon.SCYTHE] < 2:
		player.weapon_levels[player.Weapon.SCYTHE] += 1
		player.current_weapon = player.Weapon.SCYTHE
		player.update_weapon()
		

func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false
