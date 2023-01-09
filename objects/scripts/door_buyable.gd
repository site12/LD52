extends Buyable



func purchase_successful(player):
	$AnimationPlayer.play("purchased")
	$StaticBody3D/CollisionShape3D.disabled = true
	$Control.visible = false

func show_ui():
	$Control.visible = true
	$MeshInstance3D.material_overlay = highlight
	$MeshInstance3D/MeshInstance3D2.material_overlay = highlight	
	$MeshInstance3D/MeshInstance3D3.material_overlay = highlight	

func hide_ui():
	$Control.visible = false
	$MeshInstance3D.material_overlay = null
	$MeshInstance3D/MeshInstance3D2.material_overlay = null	
	$MeshInstance3D/MeshInstance3D3.material_overlay = null	
