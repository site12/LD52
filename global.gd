extends Node

enum SeedType {CARROT, POTATO, CORN}

var selected_seed:SeedType = SeedType.CARROT
var money:int = 10000

var money_before_update:int

var farm_name:String
var your_name:String
var cat_name:String

signal seed_swapped
signal update_money

func get_seed_type():
	match selected_seed:
		SeedType.CARROT :
			return("Carrot")
		SeedType.POTATO :
			return("Potato")
		SeedType.CORN :
			return("Corn")

func swap_seed():
	selected_seed += 1
	if selected_seed > SeedType.size()-1: selected_seed = 0
	print(selected_seed)
	seed_swapped.emit()

func update_seed_ui():
	seed_swapped.emit()


func spend_money(price) -> bool:
	if money >= price:
		money_before_update = money
		money -= price
		update_money.emit()
		return true
	return false

func give_money(amt):
	money_before_update = money
	money += amt
	update_money.emit()
