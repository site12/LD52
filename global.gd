extends Node

enum SeedType {CARROT, POTATO, CORN}

var selected_seed:SeedType = SeedType.CARROT
var money:int = 0

func get_seed_type():
	match selected_seed:
		SeedType.CARROT :
			return("Carrot")
		SeedType.POTATO :
			return("Potato")
		SeedType.CORN :
			return("Corn")