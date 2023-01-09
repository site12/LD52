extends Buyable



func purchase(player):
	if player.weapon_levels[player.Weapon.WATERING_CAN] < 1 and Global.spend_money(price):
		player.weapon_levels[player.Weapon.WATERING_CAN] += 1
		player.current_weapon = player.Weapon.WATERING_CAN
		player.update_weapon()
		purchase_successful(player)
		player.ui_spend_money(price)


func purchase_successful(player):

		current_type = buyable_type.MAX
		update_label()



func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false
