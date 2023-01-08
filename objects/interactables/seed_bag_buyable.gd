extends Buyable

@export var seed_type:Global.SeedType


func purchase_successful(player):
	player.add_seeds(seed_type)
