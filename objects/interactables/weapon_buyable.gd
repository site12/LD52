extends Buyable



func purchase_successful(player):
	if player.weapon_levels[player.Weapon.SCYTHE]:
		pass

func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false
