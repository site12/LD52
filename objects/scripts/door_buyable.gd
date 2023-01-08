extends Buyable



func purchase_successful(player):
	$AnimationPlayer.play("purchased")
	$StaticBody3D/CollisionShape3D.disabled = true
	$Control.visible = false

func show_ui():
	$Control.visible = true

func hide_ui():
	$Control.visible = false
