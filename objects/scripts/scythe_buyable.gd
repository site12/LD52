extends Buyable

const upgrade_prices = [400, 600, 800]

@onready var rust = preload("res://objects/weapons/mats/scythe_tool_rust.tres")
@onready var iron = preload("res://objects/weapons/mats/scythe_tool_iron.tres")
@onready var silver = preload("res://objects/weapons/mats/scythe_tool_silver.tres")

@onready var upgrade_levels = [rust, iron, silver]

func purchase(player):
	if player.weapon_levels[player.Weapon.SCYTHE] < upgrade_levels.size() and Global.spend_money(price):
		player.weapon_levels[player.Weapon.SCYTHE] += 1
		Global.upgrades_purchased +=1
		player.current_weapon = player.Weapon.SCYTHE
		player.update_weapon()
		purchase_successful(player)
		player.ui_spend_money(price)

func purchase_successful(player):
	var next_level = player.weapon_levels[player.Weapon.SCYTHE] + 1
	print(next_level)
	if next_level < upgrade_levels.size()+1:
		price = upgrade_prices[next_level-1]
		$MeshInstance3D.material_override = upgrade_levels[next_level-1]
		update_label()
	else:
		current_type = buyable_type.MAX
		update_label()


		

