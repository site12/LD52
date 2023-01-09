extends Buyable



func purchase_successful(player):
	if player.weapon_levels[player.Weapon.GUN] > 0:
		player.shotgun_node.ammo_in_reserve += 12
