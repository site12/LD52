extends Buyable

@export var seed_type:Global.SeedType


func purchase_successful(player):
	player.add_seeds(seed_type)
	Global.update_seed_ui()

func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false