extends Buyable



func purchase_successful(player):
	if player.weapon_levels[player.Weapon.WATERING_CAN] < 2:
		player.weapon_levels[player.Weapon.WATERING_CAN] += 1
		player.current_weapon = player.Weapon.WATERING_CAN
		player.update_weapon()
		

func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false
