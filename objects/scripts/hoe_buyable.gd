extends Buyable

const upgrade_prices = [0, 300, 500]

@onready var hoe_rust = preload("res://objects/weapons/mats/hoe_tool_rust.tres")
@onready var hoe_iron = preload("res://objects/weapons/mats/hoe_tool_iron.tres")
@onready var hoe_silver = preload("res://objects/weapons/mats/hoe_tool_silver.tres")

@onready var upgrade_levels = [hoe_rust, hoe_iron, hoe_silver]

func purchase(player):
	if player.weapon_levels[player.Weapon.HOE] < upgrade_levels.size() and Global.spend_money(price):
		player.weapon_levels[player.Weapon.HOE] += 1
		Global.upgrades_purchased +=1
		player.current_weapon = player.Weapon.HOE
		player.update_weapon()
		purchase_successful(player)
		player.ui_spend_money(price)

func purchase_successful(player):
	# if player.weapon_levels[player.Weapon.HOE] < upgrade_levels.size():
	# 	player.weapon_levels[player.Weapon.HOE] += 1
	# 	player.current_weapon = player.Weapon.HOE
	# 	player.update_weapon()
	var next_level = player.weapon_levels[player.Weapon.HOE] + 1
	print(next_level)
	if next_level < upgrade_levels.size()+1:
		price = upgrade_prices[next_level-1]
		$MeshInstance3D.material_override = upgrade_levels[next_level-1]
		update_label()
	else:
		current_type = buyable_type.MAX
		update_label()


		
